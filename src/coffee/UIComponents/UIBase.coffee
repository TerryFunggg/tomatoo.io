export default class UIBase
    constructor: ->
        @selector = @selector()
        @color = @color()

    selector: ->
        {
            min:            ".timer-min"
            sec:            ".timer-sec"
            timer_btn:      "#tomato-btn"
            tomato_status:  ".tomato-status"
            setting_btn:    ".tools-setting"
            switch_btn:     ".switch-btn"
            switch_active:  "switch-btn-active"
            tomato_range:   "#tomato-range"
            setting_menu:   ".setting-menu"
        }

    color: ->
        {
            tomato:        "#db524d"
            short:         "#6d9197"
            long:          "#2a9d8f"
            switch_active: "#5fae64"
        }

    @getElement: (el) -> document.querySelector el
