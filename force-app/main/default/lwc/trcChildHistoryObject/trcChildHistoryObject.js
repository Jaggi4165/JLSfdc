import {api, LightningElement} from 'lwc';

export default class TrcChildHistoryObject extends LightningElement {

    @api childObject;
    @api isLoading = false;


    get objectApiName() {
        return this.childObject?.objectApiName;
    }

    get objectLabel() {
        return this.childObject?.objectLabel;
    }

    get childIds() {
        return this.childObject?.childIds;
    }

    get hasNotEmptyResults() {
        let isEmpty = false;
        this.childObject?.childIds?.forEach(item => {
            if (item.records?.length) {
                isEmpty = true;
            }
        });
        return isEmpty;
    }

}