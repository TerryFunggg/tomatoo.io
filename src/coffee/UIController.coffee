import Tomato from '../tomato.svg'

selector =
    min: ".timer-min"
    sec: ".timer-sec"
    timer_btn: "#tomato-btn"
    tomato_status: ".tomato-status"
    setting_btn: ".tools-setting"
    switch_btn: ".switch-btn"
    switch_active: "switch-btn-active"
    tomato_range: "#tomato-range"
    setting_menu: ".setting-menu"

bgColor =
    tomato: "#db524d"
    short: "#6d9197"
    long: "#2a9d8f"


export getElement = (el) -> document.querySelector el
# export domByID = (id) -> document.getElementById id
# export domByClass = (c) -> document.querySelector ".#{c}";
export getSelector= -> selector
export getColorSelector= -> bgColor

export addTomato= ->
    status = getElement(selector.tomato_status);
    img = new Image()
    img.src = Tomato
    status.appendChild img

export emptyTomatoes= ->
    status = getElement(selector.tomato_status)
    status.innerHTML = "";

export updateTimer= (sec) ->
    minutes = Math.floor(sec/60) + ""
    seconds = sec % 60 + ""
    getElement(selector.min).innerHTML =  minutes.padStart(2,'0')
    getElement(selector.sec).innerHTML =  seconds.padStart(2,'0')

export updateTimerBtn= (str) ->
    getElement(selector.timer_btn).innerHTML = str

export updateTimerBtnColor= (mode) ->
    getElement(selector.timer_btn).style.color = bgColor[mode];

export updateBackground= (mode) ->
    getElement("body").style.backgroundColor = bgColor[mode];

export updateTitle= (title) ->
    getElement("title").innerHTML = title;

export toggleSettingMenu = ->
    menuStyle = getElement(selector.setting_menu).style
    if menuStyle.display is "flex"
        menuStyle.display =  "none"
    else
        setTimeout(() ->
            menuStyle.display = "flex"
        ,150)

export getRangeValue = -> getElement(selector.tomato_range).value

export toggleSwitch = (active) ->
   switcher = getElement(selector.switch_btn)
   switch_btn = switcher.childNodes[1]
   if active
       switcher.style.backgroundColor = "#5fae64"
       switch_btn.classList.add selector.switch_active;
   else
       switcher.style.backgroundColor = bgColor.tomato
       switch_btn.classList.remove selector.switch_active;
