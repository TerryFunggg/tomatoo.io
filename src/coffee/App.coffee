import config from "./config.coffee"
import * as Notify from "./Notify.coffee"
import * as UIController from "./UIController.coffee"
import * as Core from "./Core.coffee"

loadEventListeners = ->
    selector = UIController.getSelector()
    UIController.domByID(selector.timer_btn).addEventListener("click", startTimer)
    UIController.domByClass(selector.setting_btn).addEventListener("click", UIController.toggleSettingMenu)
    UIController.domByClass(selector.switch_btn).addEventListener("click", Core.toggleAutoStartBreak)
    UIController.domByID(selector.tomato_range).addEventListener("input", Core.rangeHandler)

startTimer =  ->
    mode = config[Core.getCurrentMode()]
    Core.startTimer(mode)


export default init = ->
    console.log "app init..."
    notifyStatus = await Notify.enableNotify();
    console.log "notify permission status: #{notifyStatus}"
    loadEventListeners()


