import { Controller } from 'stimulus';
import Greeting from '../greeting';

export default class extends Controller {
  static values = {
    data : String,
  }

  connect() {
    const greeting = new Greeting(this.element, this.dataValue);
    greeting.show();
  }
}
