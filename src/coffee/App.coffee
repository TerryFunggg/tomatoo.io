import config from "./config.coffee"
import * as Notify from "./Notify.coffee"
import * as UIController from "./UIController.coffee"
import * as Core from "./Core.coffee"

loadEventListeners = ->
    activateListeners = (type, domEl,listener) ->  UIController.getElement(domEl).addEventListener(type, listener)
    activateListeners ...e for e in getEvents()

getEvents = ->
    selector = UIController.getSelector()
    [
        ["click", selector.timer_btn, startTimer],
        ["click", selector.setting_btn, UIController.toggleSettingMenu],
        ["click", selector.switch_btn, Core.toggleAutoStartBreak],
        ["input", selector.tomato_range, Core.rangeHandler]
    ]

startTimer =  ->
    mode = config[Core.getCurrentMode()]
    Core.startTimer(mode)


export default init = ->
    console.log "app init..."
    notifyStatus = await Notify.enableNotify();
    console.log "notify permission status: #{notifyStatus}"
    loadEventListeners()


