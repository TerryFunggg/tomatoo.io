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

    getDom = (id) -> document.getElementById id

    {
        getDom
        getSelector: () -> selector
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

    cleanUp = () ->
        clearInterval interval
        interval = null
        sec = 0

     # action for each interval loop, update timer clock            
    looping = () ->
        sec--
        return  UIController.updateClock sec if sec > 0
        new Audio('../alert.mp3').play()
        cleanUp()
        UIController.updateClock config.tomato * 60
    {    
        startTimer: (mins) ->
            if interval is null and sec is 0
                sec = mins * 60 || 0
                UIController.updateTimerBtn "Stop"
                interval = setInterval(looping, 1000)
            else
                clearInterval interval
                UIController.updateTimerBtn "Start"
                UIController.updateClock config.tomato * 60
    }

# App controller
App = do (Core,UIController) ->
    timer_click = () -> App.start()
    loadEventListeners = () ->
        selector = UIController.getSelector()
        UIController.getDom(selector.timer_btn).addEventListener("click", timer_click)
    {
        init: () ->
            console.log "app init..."
            loadEventListeners()

        start: () -> Core.startTimer(config.tomato)
    }

App.init()



    



