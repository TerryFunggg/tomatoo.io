import UIBase from "./UIComponents/UIBase.coffee"
import Menu from "./UIComponents/Menu.coffee"
import Timer from "./UIComponents/Timer.coffee"
import StatusBar from "./UIComponents/StatusBar.coffee"
import Background from "./UIComponents/Background.coffee"

export default class UIController extends UIBase

    constructor: ->
        super()
        @ui         = null;
        @timer      = new Timer()
        @statusBar  = new StatusBar()
        @menu       = new Menu()
        @background = new Background()

    @instance: ->
        return @ui if ui?
        @ui = new UIController();


    addTomato: -> @statusBar.add()
    emptyTomatoes: -> @statusBar.empty()

    switchMode: (sec,mode) ->
        @updateTimer sec
        @updateTimerBtn mode
        @timer.updateBtnColor mode
        @background.update mode


    updateTimerBtn: (text) -> @timer.updateBtn text

    updateTimer: (sec) => @timer.update sec

    toggleSwitch: (status) -> @menu.toggleSwitch  status

    getRangeValue: -> @menu.getRangeValue()

    toggleSettingMenu: => @menu.toggle()

    getElement: (el) -> UIBase.getElement el

    getSelector: -> @selector
