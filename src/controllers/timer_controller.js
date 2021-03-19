import { Controller } from "stimulus"
import Tomato from '../tomato.svg'
import config from '../config.js';

export default class extends Controller {
  static values = {
    sec: Number,
    mode: String
  }
  static targets = ['minute', 'second', 'startbtn', 'statusbar']

  initialize() {
    this.interval = null;
    this.totalIntervalValue = config.interval || 4;
  }

  disconnect() {
    this.cleanUpInterval();
  }

  startTimer() {
    if (this.interval == null) {
      this.startbtnTarget.innerText = 'Stop'
      this.interval = setInterval(() => {
        this.looping();
      }, 1000);

    } else {
      // if current mode is short/long break, user can skip the break
      // by click stop button
      if (this.modeValue != "tomato") return this.finish();
      // if wull reset the timer if current mode is tomato
      this.cleanUpInterval();
      this.secValue = config[this.modeValue] * 60;
    }
  }

  looping() {
    this.secValue--;
    if (this.secValue <= 0) this.finish();
  }

  // TODO Notify
  finish() {
    this.cleanUpInterval();
    // after Short break or long break, it must change to tomato mode
    if (this.modeValue != 'tomato') return this.modeValue = 'tomato';
    // if current mode is tomato mode,
    // then change to short/long break based on number of intervals
    if (--this.totalIntervalValue > 0) {
      this.modeValue = 'short';
      this.appendTomatoIcon();
    }else{
      this.modeValue = 'long'
      // TODO: maybe move this clen action after long break;
      this.totalIntervalValue = config.interval;
      this.statusbarTarget.innerHTML = '';
    }
  }

  cleanUpInterval() {
    clearInterval(this.interval);
    this.interval = null;
    this.startbtnTarget.innerText = 'Start'
  }

  appendTomatoIcon() {
    let img = new Image();
    img.src = Tomato;
    this.statusbarTarget.appendChild(img);
  }

  chageColor(color) {
    document.body.style.backgroundColor = color;
    this.startbtnTarget.style.color = color
  }

  /*
   * Value Chage
   */
  secValueChanged() {
    let minutes = Math.floor(this.secValue / 60) + ""
    let seconds = this.secValue % 60 + ""
    this.minuteTarget.innerText = minutes.padStart(2, '0');
    this.secondTarget.innerText = seconds.padStart(2, '0');
  }

  // TODO: add tomato

  modeValueChanged() {
    this.secValue = config[this.modeValue] * 60;
    switch (this.modeValue) {
      case 'tomato':
        this.chageColor('#db524d')
        break;
      case 'short':
        this.chageColor('#6d9197')
        break;
      case 'long':
        this.chageColor('#2a9d8f');
        break;
    }
  }
}
