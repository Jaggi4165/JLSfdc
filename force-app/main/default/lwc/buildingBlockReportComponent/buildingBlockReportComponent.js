import { LightningElement,track,wire } from 'lwc';
import oppReportData from '@salesforce/apex/BuildingBlocksIncentiveController.oppReportData';
export default class BuildingBlockReportComponent extends LightningElement {
    oppColumns = [
        { label: 'Opportunity Owner Name', fieldName: 'oppOwner' },
        { label: 'number of opportunities handling', fieldName: 'handling' },
        { label: 'success rate of opportunities', fieldName: 'successRate' ,type:'decimal'}
    ];
    @track opportunityData;

    @wire(oppReportData)
    wiredContacts({ error, data }) {
        if (data) {
            this.opportunityData = data;
            console.log('opp data===>',JSON.stringify(data));
            this.error = undefined;
        } else if (error) {
            console.log('opp --- error===>',error);
            this.error = error;
            this.opportunityData = undefined;
        }
    }
}