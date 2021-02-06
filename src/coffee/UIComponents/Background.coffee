import UIBase from "./UIBase.coffee"

export default class Background extends UIBase
    constructor: ->
        super()

    update: (mode) ->
        UIBase.getElement("body").style.backgroundColor = @color[mode];
