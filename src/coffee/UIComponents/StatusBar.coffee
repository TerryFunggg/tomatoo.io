import UIBase from "./UIBase.coffee"
import Tomato from '../../tomato.svg'

export default class StatusBar extends UIBase
    constructor: ->
        super()

    add: ->
        status = UIBase.getElement(@selector.tomato_status);
        img = new Image()
        img.src = Tomato
        status.appendChild img

    empty: ->
        status = UIBase.getElement(@selector.tomato_status)
        status.innerHTML = "";
