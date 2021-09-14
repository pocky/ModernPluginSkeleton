export default class Greeting {
  constructor(element, value) {
    this.element = element;
    this.value = value;
  }

  show() {
    setTimeout(() => {
      this.element.innerHTML = this.value;
    }, 1000);
  }
}
