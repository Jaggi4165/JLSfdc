import { LightningElement, track } from 'lwc';
import getUserTilePermissions from '@salesforce/apex/UserTileController.getUserTilePermissions';

export default class UserTileManager extends LightningElement {
    @track showReports = false;
    @track showDashboard = false;
    @track showAdminTools = false;

    connectedCallback() {
        getUserTilePermissions()
            .then(user => {
                this.showReports = user.Show_Reports__c;
                this.showDashboard = user.Show_Dashboard__c;
                this.showAdminTools = user.Show_Admin_Tools__c;
            })
            .catch(error => {
                console.error('Error fetching user tile settings: ', error);
            });
    }
}