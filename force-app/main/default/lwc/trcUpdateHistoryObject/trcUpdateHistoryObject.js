import {api, LightningElement, track, wire} from "lwc";

import {getRecord}                      from "lightning/uiRecordApi";
import {comparator, deepClone}          from "c/trcStructureUtil"

const UPDATE_TABLE_COLUMNS = [
    { label: 'Date', fieldName: 'createdDate', wrapText: true, sortable: true },
    { label: 'Field', fieldName: 'fieldLabel', wrapText: true, sortable: true },
    { label: 'User', fieldName: 'userName', wrapText: true, sortable: true },
    { label: 'Original Value', fieldName: 'oldValue', wrapText: true, type: 'image'},
    { label: 'New Value', fieldName: 'newValue', wrapText: true, type: 'image'},
    { label: '', type: 'button-icon', cellAttributes: { class: 'exdBtn', alignment: 'left' },
        typeAttributes: { class: { fieldName: 'expandBtn' }, iconClass: 'removeIcon',
            iconName: 'utility:expand', title: 'expand', name: 'expand',
            variant: 'container', disabled: { fieldName: 'disableAction' } }, initialWidth: 45 }

];

const INSERT_TABLE_COLUMNS = [
    { label: 'Field', fieldName: 'fieldLabel', wrapText: false, sortable: true },
    { label: 'User', fieldName: 'userName', wrapText: false, sortable: true },
    { label: 'Original Value', fieldName: 'oldValue', wrapText: false, type: 'image'},
    { label: 'New Value', fieldName: 'newValue', wrapText: false, type: 'image'},
    { label: '', type: 'button-icon', cellAttributes: { class: 'exdBtn', alignment: 'left' },
        typeAttributes: { class: { fieldName: 'expandBtn' }, iconClass: 'removeIcon',
            iconName: 'utility:expand', title: 'expand', name: 'expand',
            variant: 'container', disabled: { fieldName: 'disableAction' } }, initialWidth: 45 }

];

const DATETIME_FORMAT = {
    month: '2-digit',
    day: '2-digit',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
}

const DATE_FORMAT = {
    month: '2-digit',
    day: '2-digit',
    year: 'numeric',
}

export default class TrcUpdateHistoryObject extends LightningElement {

    @api result = {};

    userLocale = 'en-US';

    @track updatedData = [];
    @track fieldName = [];

    data = [];
    totalRecords;
    itemsPerPage = 500;
    recordsToDisplay = [];
    pageNumber = 1;
    sortedBy = 'createdDate';
    sortDirection = 'desc';

    expandedRow = {};
    showExpandedPopup = false;
    styleTagAppended = false;
    wiredName = null;


    @wire(getRecord, { recordId: '$parentId', fields : '$fieldName'})
    wiredRecord({ error, data }) {
        if (error) {
            console.log(JSON.stringify(error));
        } else if (data) {
            this.wiredName = data.fields['Name'].value;
        }
    }

    get parentId() {
        return this.result?.parentId;
    }

    get operationType() {
        return this.result?.operationType;
    }

    get objectApiName() {
        return this.result?.objectApiName;
    }

    get isParent() {
        return this.result?.isParent;
    }

    get tableColumns() {
        if (this.operationType === 'Update') {
            return UPDATE_TABLE_COLUMNS;
        }
        return INSERT_TABLE_COLUMNS;
    }

    get isNotParentObject() {
        return !this.isParent;
    }

    get recordURL() {
        return '/' + this.parentId;
    }

    get recordName() {
        return this.wiredName ?? this.parentId;
    }

    get isUpdateOperation () {
        return this.operationType === 'Update';
    }

    get isCreateOperation () {
        return this.operationType === 'Create';
    }

    get isDeleteOperation () {
        return this.operationType === 'Delete';
    }

    get operationDate() {
        if (!this.isUpdateOperation && this.records?.length) {
            return this.records[0].createdDate;
        }
        return '';
    }

    get records(){
        if(this.updatedData && this.updatedData.length > 0){
            this.data = this.updatedData.map(a => Object.assign({}, a));
            this.totalRecords = this.updatedData.length;
            this.setRecordsToDisplay();
            return this.recordsToDisplay;
        }
        return [];
    }

    get hasOldLink() {
        return this.expandedRow.oldValue?.toString().includes('/servlet');
    }

    get hasNewLink() {
        return this.expandedRow.newValue?.toString().includes('/servlet');
    }

    async connectedCallback() {
        this.fieldName.push(this.objectApiName + '.Name');
        this.getLocaleSettings();
        this.composeDataForDatatable();
    }

    renderedCallback() {
        if (!this.styleTagAppended) {
            const mainForm = this.template.querySelector('.source');
            if (mainForm) {
                let styleSource = document.createElement('style');
                styleSource.innerText = '.slds-form-element__label.slds-form-element__legend{font-weight: normal;}.slds-form-element__control .slds-radio{display: inline-block !important;padding-right: 15px;}';
                styleSource.innerText += '.slds-th__action{background-color: #f3f3f3 !important;} .slds-icon_container_circle{background-color: limegreen !important;} .exdBtn{ padding:0 0.15rem !important;}';
                styleSource.innerText += '.exdBtn .slds-icon{ width: var(--lwc-squareIconXxSmallContent,.875rem);height: var(--lwc-squareIconXxSmallContent,.875rem);line-height: var(--lwc-lineHeightReset,1);}';
                styleSource.innerText += '.slds-hyphenate { width: 100%;}';
                mainForm.appendChild(styleSource);
                this.styleTagAppended = true;
            }
        }
    }

    getLocaleSettings() {
        this.userLocale = this.result?.userLocale ?? this.userLocale;
        DATETIME_FORMAT.timeZone = this.result?.timeZone;
    }

    composeDataForDatatable() {
        const records = deepClone(this.result?.records);
        records?.forEach(record => {
            record.internalDate = record.createdDate;
            record.createdDate = (new Date(record.createdDate)).toLocaleDateString(this.userLocale, DATETIME_FORMAT);

            if (record.fieldType === 'DATETIME') {
                if (record.oldValue) {
                    record.oldValue = this.createDateTime(record.oldValue);
                }
                if (record.newValue) {
                    record.newValue = this.createDateTime(record.newValue);
                }
            }
            if (record.fieldType === 'DATE') {
                if (record.oldValue) {
                    record.oldValue = (new Date(record.oldValue)).toLocaleDateString(this.userLocale, DATE_FORMAT);
                }
                if (record.newValue) {
                    record.newValue = (new Date(record.newValue)).toLocaleDateString(this.userLocale, DATE_FORMAT);
                }
            }
        });
        this.updatedData = records;
        this.setRecordsToDisplay();
    }

    createDateTime(value) {
        const utcDate = value.substring(0,4) + '-' + value.substring(5,7) + '-' + value.substring(8,10) + 'T' +
            value.substring(11,13) + ':' + value.substring(14,16) + ':' + value.substring(17) + '.000Z';
        return (new Date(utcDate)).toLocaleDateString(this.userLocale, DATETIME_FORMAT);
    }

    handleClick(event) {
        this.expandedRow = event.detail.row;
        this.showExpandedPopup = true;
    }

    handlePopupClose() {
        this.expandedRow = {};
        this.showExpandedPopup = false;
    }

    handleSortData (event) {
        this.sortedBy = event.detail.fieldName;
        this.sortDirection = event.detail.sortDirection;
        this.setRecordsToDisplay();
    }

    setRecordsToDisplay() {
        this.recordsToDisplay = [];
        if (!this.itemsPerPage) this.itemsPerPage = this.totalRecords;

        if (typeof this.data !== "undefined") {
            if (this.sortDirection) {
                console.log(JSON.stringify(this.data));
                const sortField = this.sortedBy === 'createdDate' ? 'internalDate' : this.sortedBy;
                this.data.sort(comparator(sortField, this.sortDirection));
            }
            let startPoint = (this.pageNumber - 1) * this.itemsPerPage;
            let endPoint = this.pageNumber * this.itemsPerPage;
            this.recordsToDisplay = this.data.slice(startPoint, endPoint);
        }
    }

    handlePageChange(event) {
        this.pageNumber = event.detail;
        this.setRecordsToDisplay();
    }

}