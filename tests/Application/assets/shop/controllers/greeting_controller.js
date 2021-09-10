import { Controller } from 'stimulus';

export default class extends Controller {
  static values = {
    data : String,
    id : String
  }

  connect() {
    setTimeout(this.innerHTML = this.dataValue,1000);
  }
}
