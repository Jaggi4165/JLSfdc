import {api, LightningElement, track, wire}         from 'lwc';
import {getObjectInfo}                              from "lightning/uiObjectInfoApi";
import {deepClone}                                  from "c/trcStructureUtil"

export default class TrcAdminObject extends LightningElement {
    @api config;
    isLoading = true;
    objectInfo = {};
    @track optionsPart1 = [];
    @track optionsPart2 = [];
    @track optionsPart3 = [];

    @track allOptions = [];

    get objectApiName() {
        return this.config?.objectApiName;
    }

    get objectLabel() {
        return this.config?.objectLabel;
    }

    get isActive() {
        return this.config.isActive;
    }

    get isTriggerNotActive() {
        return this.config.isTriggerNotActive;
    }

    get isChecked() {
        return this.config?.activeFields;
    }

    get filterField() {
        if (this.config?.filterField) {
            return {
                id: this.config?.filterField,
                title: this.objectInfo[this.config?.filterField]?.label,
                icon: 'standard:work_order_item'
            };
        } else {
            return [];
        }
    }

    get groupField() {
        if (this.config?.groupField) {
            return {
                id: this.config?.groupField,
                title: this.objectInfo[this.config?.groupField]?.label,
                icon: 'standard:work_order_item'
            };
        } else {
            return [];
        }
    }

    get controlledField() {
        if (this.config?.parentControlledIdField) {
            return {
                id: this.config?.parentControlledIdField,
                title: this.objectInfo[this.config?.parentControlledIdField]?.label,
                icon: 'standard:work_order_item'
            };
        } else {
            return [];
        }
    }

    get fieldsOptions() {
        const chunk = Object.keys(this.allOptions).length/3;
        this.clearOptions();

        this.allOptions.map(option => option.checked = this.config?.activeFields?.includes(option.apiName));

        this.allOptions.forEach(optionObject => {
            if (this.optionsPart1.length <= chunk) {
                this.optionsPart1.push(optionObject);
            } else if (this.optionsPart2.length <= chunk){
                this.optionsPart2.push(optionObject);
            } else {
                this.optionsPart3.push(optionObject);
            }
        });

        return this.allOptions;
    }

    get fieldsOptions1() {
        return this.optionsPart1;
    }

    get fieldsOptions2() {
        return this.optionsPart2;
    }

    get fieldsOptions3() {
        return this.optionsPart3;
    }

    get booleanFieldOptions() {
        return Object.keys(this.objectInfo)
            .filter(fieldName => this.objectInfo[fieldName].dataType === 'Boolean')
            .map(fieldName => ({
                id: fieldName,
                title: this.objectInfo[fieldName].label,
                subtitle: this.objectInfo[fieldName].apiName,
                icon : 'standard:work_order_item',
            }));
    }

    get textFieldOptions() {
        return Object.keys(this.objectInfo)
            .filter(fieldName => this.objectInfo[fieldName].dataType === 'String')
            .map(fieldName => ({
                id: fieldName,
                title: this.objectInfo[fieldName].label,
                subtitle: this.objectInfo[fieldName].apiName,
                icon : 'standard:work_order_item',
            }));
    }

    get lookupOptions() {
        return Object.keys(this.objectInfo)
            .filter(fieldName => (this.objectInfo[fieldName].dataType === 'Reference' || this.objectInfo[fieldName].dataType === 'String'))
            .map(fieldName => ({
                id: fieldName,
                title: this.objectInfo[fieldName].label,
                subtitle: this.objectInfo[fieldName].apiName,
                icon : 'standard:work_order_item',
            }));
    }


    @wire(getObjectInfo, { objectApiName: '$objectApiName' })
    ObjectInfo({ error, data }) {
        if (data) {
            this.objectInfo = deepClone(data.fields);
            this.makeFieldOptions();
            this.isLoading = false;
        }
        if (error) {
            this.isLoading = false;
            console.error("getObjectInfos error", JSON.stringify(error));
        }
    }

    makeFieldOptions() {
        this.allOptions = [];
        Object.keys(this.objectInfo).forEach(field => {
            const optionObject = {
                apiName: this.objectInfo[field].apiName,
                label: this.objectInfo[field].label,
                checked: this.config?.activeFields?.includes(this.objectInfo[field].apiName)
            };
            this.allOptions.push(optionObject);
        });

        this.allOptions.sort((a, b) => {
            if (a.checked < b.checked) return 1;
            if (a.checked > b.checked) return -1;
            if (a.label < b.label) return -1;
            if (a.label > b.label) return 1;
            return 0;
        });
    }

    clearOptions() {
        this.optionsPart1 = [];
        this.optionsPart2 = [];
        this.optionsPart3 = [];
    }

    handleBooleanLookupClick(event) {
        const lookupElement = event.target;
        lookupElement.setSearchResults(this.booleanFieldOptions);
    }

    handleGroupLookupClick(event) {
        const lookupElement = event.target;
        lookupElement.setSearchResults(this.textFieldOptions);
    }

    handleControlledLookupClick(event) {
        const lookupElement = event.target;
        lookupElement.setSearchResults(this.lookupOptions);
    }

    handleBooleanLookupSearch(event) {
        const lookupElement = event.target;
        const requestedWord = event.detail.searchTerm;
        if (requestedWord.length >= 1) {
            lookupElement.setSearchResults(
                this.booleanFieldOptions
                    .filter(option => option.title.toLowerCase().includes(requestedWord) || option.subtitle.toLowerCase().includes(requestedWord))
            );
        }
    }

    handleGroupLookupSearch(event) {
        const lookupElement = event.target;
        const requestedWord = event.detail.searchTerm;
        if (requestedWord.length >= 1) {
            lookupElement.setSearchResults(
                this.textFieldOptions
                    .filter(option => option.title.toLowerCase().includes(requestedWord) || option.subtitle.toLowerCase().includes(requestedWord))
            );
        }
    }

    handleControlledLookupSearch(event) {
        const lookupElement = event.target;
        const requestedWord = event.detail.searchTerm;
        if (requestedWord.length >= 1) {
            lookupElement.setSearchResults(
                this.lookupOptions
                    .filter(option => option.title.toLowerCase().includes(requestedWord) || option.subtitle.toLowerCase().includes(requestedWord))
            );
        }
    }

    handleBooleanLookupSelect(event) {
        this.dispatchEvent(new CustomEvent('bypass', {
            detail: {
                objectName: this.objectApiName,
                fieldName: event.detail
            }
        }));
    }

    handleGroupLookupSelect(event) {
        this.dispatchEvent(new CustomEvent('groupselect', {
            detail: {
                objectName: this.objectApiName,
                fieldName: event.detail
            }
        }));
    }

    handleControlledLookupSelect(event) {
        this.dispatchEvent(new CustomEvent('controlledselect', {
            detail: {
                objectName: this.objectApiName,
                fieldName: event.detail
            }
        }));
    }

    onSelectAll() {
        this.dispatchEvent(new CustomEvent('allselect', {
            detail: {
                objectName: this.objectApiName,
                fieldNames: Object.keys(this.objectInfo)
            }
        }));
    }

    onActiveToggle(event) {
        this.dispatchEvent(new CustomEvent('toggle', {
            detail: {
                objectName: this.objectApiName,
                isActive: event.target.checked
            }
        }));
    }

    onDeselectAll() {
        this.dispatchEvent(new CustomEvent('deselect', {
            detail: {
                objectName: this.objectApiName
            }
        }));
    }

    handleFieldChange(event) {
        this.dispatchEvent(new CustomEvent('fieldchange', {
            detail: {
                objectName: this.objectApiName,
                fieldName: event.detail.fieldName,
                checked: event.detail.checked
            }
        }));
    }

    async saveSettings() {
        this.dispatchEvent(new CustomEvent('save', {detail: {objectName: this.objectApiName}}));
    }

    deleteSettings() {
        this.dispatchEvent(new CustomEvent('delete', {detail: {objectName: this.objectApiName}}));
    }
}