config = 
    tomato: 25,
    short: 5,
    long: 15,
    interval: 4

# NotificationController
Notify = do ->
    checkBrowserSupportNotify = -> 'Notification' in window
    checkPermissionEnabled = -> 
        Notification.permission isnt 'granted' and Notification.permission isnt 'denied'
    permissionIsGranted = ( permission ) -> permission is 'granted'
    enableNotify = ->
        if checkBrowserSupportNotify and checkPermissionEnabled
            Notification.requestPermission().then( permissionIsGranted )
    {
        enableNotify,
        send: (msg) -> new Notification(msg)
    }    


# handle UI
UIController =  do ->
    selector = 
        min: "timer-min"
        sec: "timer-sec"
        timer_btn: "tomato-btn"
        tomato_status: "tomato-status"

    bgColor =
        tomato: "#db524d"
        short: "#6d9197"
        long: "#2a9d8f"

    domByID = (id) -> document.getElementById id
    tomatoIcon = -> '<img src="tomato.svg" />'


    {
        domByID,
        bgColor,
        getSelector: -> selector
        
        addTomato: ->
            status = document.querySelector(".#{selector.tomato_status}")
            status.innerHTML += tomatoIcon()

        emptyTomatoes: ->
            status = document.querySelector(".#{selector.tomato_status}")
            status.innerHTML = "";

        updateTimer: (sec) ->
            minutes = Math.floor(sec/60) + ""
            seconds = sec % 60 + ""
            domByID(selector.min).innerHTML =  minutes.padStart(2,'0')
            domByID(selector.sec).innerHTML =  seconds.padStart(2,'0')

        updateTimerBtn: (str) ->
            domByID(selector.timer_btn).innerHTML = str

        updateTimerBtnColor: (mode) ->
            domByID(selector.timer_btn).style.color = bgColor[mode];

        updateBackground: (mode) ->
            document.querySelector("body").style.backgroundColor = bgColor[mode];

        updateTitle: (title) ->
            document.querySelector("title").innerHTML = title;
    }

# Core of tomatoo
Core = do (UIController,Notify) ->
    interval = null
    sec = 0
    numOfTomato = config.interval;
    currentMode = "tomato"

    getCurrentMode = -> currentMode

    cleanUpInterval = ->
        clearInterval interval
        interval = null
        sec = 0
    
    cleanUpTomatoes = ->
        UIController.emptyTomatoes()
        numOfTomato = config.interval;
    
    addTomatoStatus = ->
            numOfTomato--;
            UIController.addTomato()

    switchMode = (mode) ->
        currentMode = mode
        UIController.updateTimer config[mode] * 60;
        UIController.updateBackground mode;
        UIController.updateTimerBtnColor mode


    longBreak = ->
        switchMode "long"
        UIController.updateTimerBtnColor currentMode
        cleanUpTomatoes()

    finish = ->
        cleanUpInterval()
        UIController.updateTimerBtn "Start"

        if currentMode is "tomato"
            Notify.send("You finish a tomato! Take a rest~");
            return longBreak() if numOfTomato <= 1
            # short break
            addTomatoStatus()
            switchMode "short"

        else
           Notify.send("now come back and keep going~") if currentMode is "short"
           Notify.send("You just finsihed long break~ Want to come back?") if currentMode is "long"
           switchMode "tomato"

     # action for each interval loop, update timer clock            
    looping = ->
        sec--
        return finish() unless sec > 0
        UIController.updateTimer sec

    {    
        getCurrentMode,
        startTimer: (mins) ->
            if interval is null and sec is 0
                sec = mins * 60 || 0
                UIController.updateTimerBtn "Stop"
                interval = setInterval(looping, 1000)
            else
                # user can skip rest action
                finish() if currentMode isnt "tomato"
                cleanUpInterval()
                UIController.updateTimerBtn "Start"
                UIController.updateTimer config.tomato * 60
    }

# App controller
App = do (Core,UIController,Notify) ->
    loadEventListeners = ->
        selector = UIController.getSelector()
        UIController.domByID(selector.timer_btn).addEventListener("click", start)
    
    start =  -> 
        mode = config[Core.getCurrentMode()]
        Core.startTimer(mode)

    {
        init: ->
            console.log "app init..."
            notifyStatus = await Notify.enableNotify(); 
            console.log "notify permission status: #{notifyStatus}"
            loadEventListeners()
    }

App.init()



    



