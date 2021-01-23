config = 
    tomato: 25,
    short: 5,
    long: 15
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

    domByID = (id) -> document.getElementById id
    tomatoIcon = -> '<img src="tomato.svg" />'

    {
        domByID,
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
    }

# Core of tomatoo
Core = do (UIController,Notify) ->
    interval = null
    sec = 0
    numOfTomato = 0;

    cleanUpInterval = ->
        clearInterval interval
        interval = null
        sec = 0
    
    cleanUpTomatoes = ->
        UIController.emptyTomatoes()
        numOfTomato = 0;
    
    addTomatoStatus = ->
        if  numOfTomato < 4
            numOfTomato++
            UIController.addTomato()

    checkStatus = -> 
        cleanUpTomatoes() if numOfTomato >= 4
        

     # action for each interval loop, update timer clock            
    looping = ->
        sec--
        return  UIController.updateTimer sec if sec > 0
        # finish a tomato
        Notify.send("You finish a tomato! Take a rest~");
        cleanUpInterval()
        UIController.updateTimer config.tomato * 60
        addTomatoStatus()
        # TODO: goto short/long break if finish a tomato
        UIController.updateTimerBtn "Start"

    {    
        startTimer: (mins) ->
            if interval is null and sec is 0
                sec = mins * 60 || 0
                # if already have 4 tomato, it will start a new round
                checkStatus()
                UIController.updateTimerBtn "Stop"
                interval = setInterval(looping, 1000)
            else
                # user type the stop btn
                cleanUpInterval()
                UIController.updateTimerBtn "Start"
                UIController.updateTimer config.tomato * 60
    }

# App controller
App = do (Core,UIController,Notify) ->
    timer_click = () -> start()
    loadEventListeners = ->
        selector = UIController.getSelector()
        UIController.domByID(selector.timer_btn).addEventListener("click", timer_click)
    
    start =  -> Core.startTimer(config.tomato)

    {
        init: ->
            console.log "app init..."
            notifyStatus = await Notify.enableNotify(); 
            console.log "notify permission status: #{notifyStatus}"
            loadEventListeners()
    }

App.init()



    



