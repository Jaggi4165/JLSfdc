import { LightningElement,wire,track } from 'lwc';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { refreshApex } from '@salesforce/apex';
import SCHOOL_SETTINGS from '@salesforce/apex/MiscStylingHooksController.getSchoolSetting';
import updateBooleanSchoolSetting from '@salesforce/apex/MiscStylingHooksController.updateBooleanSchoolSetting';
import updateDateSchoolSetting from '@salesforce/apex/MiscStylingHooksController.updateDateSchoolSetting';
export default class MiscStylingHooks extends LightningElement {
    @track triggerService;
    @track emailService;
    @track orgExpiryDate;
    @track customSettingField;
    @track customSettingValue;

    @wire (SCHOOL_SETTINGS,{}) config({error,data}){
        if(data){
            this.emailService = data.Email_Services__c;
            this.triggerService = data.Trigger_Services__c;
            this.orgExpiryDate = data.Org_Expiry_Date__c;
        }
    }
    onClickToggle(event){
        this.customSettingField = event.target.label;
        this.customSettingValue = event.target.checked;
        this.updateCustomSetting();  
    }
    onChangeDate(event){
        this.customSettingField = event.target.label;
        this.customSettingValue = event.target.value;
        this.updateDateCustomSetting();  
    }
    updateCustomSetting(){
        updateBooleanSchoolSetting({ field: this.customSettingField,value:this.customSettingValue })
		.then(result => {
            this.showToast('Success', 'Custom setting updated for Boolean Datatype.', 'success');
		})
		.catch(error => {
			this.showToast('Error', error , 'error');
		})
    }
    updateDateCustomSetting(){
        updateDateSchoolSetting({ field: this.customSettingField,value:this.customSettingValue })
		.then(result => {
            this.showToast('Success', 'Custom setting updated for Date Datatype.', 'success');
		})
		.catch(error => {
            console.log(error);
			this.showToast('Error', error , 'error');
		})
    }
    showToast(title, message, variant){
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
    refreshData() {
        SCHOOL_SETTINGS({ field: this.customSettingField,value:this.customSettingValue })
		.then(data => {
            this.emailService = data.Email_Services__c;
            this.triggerService = data.Trigger_Services__c;
            this.orgExpiryDate = data.Org_Expiry_Date__c;
		})
		.catch(error => {
			this.showToast('Error', error , 'error');
		})
    }
    
}