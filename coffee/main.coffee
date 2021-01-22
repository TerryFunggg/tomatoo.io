config = 
    tomato: 25,
    short: 5,
    long: 15
    interval: 4

# handle UI
UIController =  do ->
    selector = 
        min: "timer-min"
        sec: "timer-sec"
        timer_btn: "tomato-btn"
        tomato_status: "tomato-status"

    getDom = (id) -> document.getElementById id
    getDoneIcon = -> '<img src="tomato.svg" />'

    {
        getDom
        getSelector: -> selector
        
        addDoneStatus: ->
            status = document.querySelector(".#{selector.tomato_status}")
            status.innerHTML += getDoneIcon()

        emptyStatus: ->
            status = document.querySelector(".#{selector.tomato_status}")
            status.innerHTML = "";

        updateClock: (sec) ->
            minutes = Math.floor(sec/60) + ""
            seconds = sec % 60 + ""
            getDom(selector.min).innerHTML =  minutes.padStart(2,'0')
            getDom(selector.sec).innerHTML =  seconds.padStart(2,'0')

        updateTimerBtn: (str) ->
            getDom(selector.timer_btn).innerHTML = str
    }

# Core of tomatoo
Core = do (UIController) ->
    interval = null
    sec = 0
    numOfTomato = 0;

    cleanUpInterval = ->
        clearInterval interval
        interval = null
        sec = 0
    
    cleanUpStatus = ->
        UIController.emptyStatus()
        numOfTomato = 0;
    
    addTomatoStatus = ->
        if  numOfTomato < 4
            numOfTomato++
            UIController.addDoneStatus()

    checkStatus = -> 
        cleanUpStatus() if numOfTomato >= 4
        

     # action for each interval loop, update timer clock            
    looping = ->
        sec--
        return  UIController.updateClock sec if sec > 0
        # finish
        new Audio('../alert.mp3').play()
        cleanUpInterval()
        UIController.updateClock config.tomato * 60
        # add status
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
                UIController.updateClock config.tomato * 60
    }

# App controller
App = do (Core,UIController) ->
    timer_click = () -> App.start()
    loadEventListeners = ->
        selector = UIController.getSelector()
        UIController.getDom(selector.timer_btn).addEventListener("click", timer_click)
    {
        init: ->
            console.log "app init..."
            loadEventListeners()

        start: -> Core.startTimer(config.tomato)
    }

App.init()



    



