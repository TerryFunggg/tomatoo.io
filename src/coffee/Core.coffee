import config from "./config.coffee"
import * as Notify from "./Notify.coffee"
import * as UIController from "./UIController.coffee"

interval = null
sec = 0
numOfTomato = config.interval;
currentMode = "tomato"

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

export getCurrentMode = -> currentMode

export startTimer = (mins) ->
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
