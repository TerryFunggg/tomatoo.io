import UIBase from "./UIBase.coffee"

export default class Menu extends UIBase
    constructor: ->
        super()

    toggle: ->
        menuStyle = UIBase.getElement(@selector.setting_menu).style
        return menuStyle.display =  "none" if menuStyle.display is "flex"
        displayMenu = () =>  menuStyle.display = "flex"
        setTimeout(displayMenu,150)


    # Tomato min range values
    getRangeValue: -> UIBase.getElement(@selector.tomato_range).value


    # auto break button
    toggleSwitch: (active) ->
        switcher = UIBase.getElement(@selector.switch_btn)
        switch_btn = switcher.childNodes[1]
        if active
            switcher.style.backgroundColor = @color.switch_active
            switch_btn.classList.add @selector.switch_active;
        else
            switcher.style.backgroundColor = @color.tomato
            switch_btn.classList.remove @selector.switch_active;
