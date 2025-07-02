import { LightningElement } from 'lwc';
export default class TriggerButtonOnEnter extends LightningElement {
    txtValue;
  showValue = false;

  renderedCallback() {
    this.template
      .querySelector("lightning-input")
      .addEventListener("keydown", (event) => {
        if (event.key === "Enter") {
          this.handleButton();
        }
      });
  }

  handleChange(event) {
    this.txtValue = event.target.value;
  }
  handleButton() {
    this.showValue = true;
  }
}