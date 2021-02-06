import config from "./config.coffee"
import * as Notify from "./Notify.coffee"
import UI from "./UIController.coffee"

interval = null
sec = 0
numOfTomato = config.interval;
currentMode = "tomato"
auto_break = false;

cleanUpInterval = ->
    clearInterval interval
    interval = null
    sec = 0

cleanUpTomatoes = ->
    UI.instance().emptyTomatoes()
    numOfTomato = config.interval;

addTomatoStatus = ->
        numOfTomato--;
        UI.instance().addTomato()

switchMode = (mode) ->
    currentMode = mode
    UI.instance().switchMode(config[mode] * 60, mode)
    startTimer config[mode] if auto_break and mode isnt "tomato"

longBreak = ->
    switchMode "long"
    cleanUpTomatoes()

finish = ->
    cleanUpInterval()
    UI.instance().updateTimerBtn "Start"

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
    UI.instance().updateTimer sec

export getCurrentMode = -> currentMode

export startTimer = (mins) ->
    if interval is null and sec is 0
        sec = mins * 60 || 0
        UI.instance().updateTimerBtn "Stop"
        interval = setInterval(looping, 1000)
    else
        # user can skip rest action
        finish() if currentMode isnt "tomato"
        cleanUpInterval()
        UI.instance().updateTimerBtn "Start"
        UI.instance().updateTimer config.tomato * 60

export toggleAutoStartBreak = ->
    auto_break = !auto_break;
    UI.instance().toggleSwitch auto_break

export rangeHandler = ->
    value = UI.instance().getRangeValue()
    config.tomato = value
    if interval is null
        UI.instance().updateTimer value * 60
