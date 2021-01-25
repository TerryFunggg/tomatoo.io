import Tomato from '../tomato.svg'

selector =
    min: "timer-min"
    sec: "timer-sec"
    timer_btn: "tomato-btn"
    tomato_status: "tomato-status"

bgColor =
    tomato: "#db524d"
    short: "#6d9197"
    long: "#2a9d8f"


export domByID = (id) -> document.getElementById id
export getSelector= -> selector
export getColorSelector= -> bgColor

export addTomato= ->
    status = document.querySelector(".#{selector.tomato_status}")
    img = new Image()
    img.src = Tomato
    status.appendChild img

export emptyTomatoes= ->
    status = document.querySelector(".#{selector.tomato_status}")
    status.innerHTML = "";

export updateTimer= (sec) ->
    minutes = Math.floor(sec/60) + ""
    seconds = sec % 60 + ""
    domByID(selector.min).innerHTML =  minutes.padStart(2,'0')
    domByID(selector.sec).innerHTML =  seconds.padStart(2,'0')

export updateTimerBtn= (str) ->
    domByID(selector.timer_btn).innerHTML = str

export updateTimerBtnColor= (mode) ->
    domByID(selector.timer_btn).style.color = bgColor[mode];

export updateBackground= (mode) ->
    document.querySelector("body").style.backgroundColor = bgColor[mode];

export updateTitle= (title) ->
    document.querySelector("title").innerHTML = title;
