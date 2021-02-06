import UIBase from "./UIBase.coffee"

export default class Timer extends UIBase
    constructor: ->
        super()

    update: (sec) ->
        minutes = Math.floor(sec/60) + ""
        seconds = sec % 60 + ""
        UIBase.getElement(@selector.min).innerHTML =  minutes.padStart(2,'0')
        UIBase.getElement(@selector.sec).innerHTML =  seconds.padStart(2,'0')


    updateBtn: (str) =>
        UIBase.getElement(@selector.timer_btn).innerHTML = str


    updateBtnColor: (mode) =>
        UIBase.getElement(@selector.timer_btn).style.color = @color[mode];
