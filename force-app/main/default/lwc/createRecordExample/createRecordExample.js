import { LightningElement, track } from "lwc";

import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { createRecord } from "lightning/uiRecordApi";

import ACCOUNT_OBJECT from "@salesforce/schema/Account";

export default class CreateRecordExample extends LightningElement {
    accountRecord = {};
    isLoading = false;

    handleChange(event) {
        this.accountRecord[event.target.name] = event.target.value;
    }

    createAccount() {
        this.isLoading = true;
        const fields = this.accountRecord;

        const recordInput = { apiName: ACCOUNT_OBJECT.objectApiName, fields };

        createRecord(recordInput)
            .then((account) => {
                this.accountId = account.id;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "Success",
                        message: "Account created successfully!",
                        variant: "success"
                    })
                );

                this.accountRecord = {};
            })
            .catch((error) => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: "Error creating record",
                        message: "Error",
                        variant: "error"
                    })
                );
            })
            .finally(() => {
                this.isLoading = false;
            });
    }
}