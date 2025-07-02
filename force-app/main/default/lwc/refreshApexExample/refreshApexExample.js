import { LightningElement, wire,api,track } from 'lwc';
import fetchOppList from '@salesforce/apex/RefreshApexController.fetchOppList';
import {refreshApex} from '@salesforce/apex';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import { deleteRecord } from 'lightning/uiRecordApi';
const columns = [
    {label:'Name',fieldName:'Name'},
    {label:'Stage',fieldName:'StageName'},
    {label:'Amount',fieldName:'Amount'}
];
export default class RefreshApexExample extends LightningElement {
    @track oppRecords;
    @track error;
    oppRecordsCopy;
    columns = columns;
    @wire(fetchOppList) 
    wiredDate(value){
        this.oppRecordsCopy = value;
        const {data,error} = value;
        if(data){
            this.oppRecords = data;
        }
        else if(error){
            this.error = error;
        }
    }
    handelRefresh(){
        refreshApex(this.oppRecordsCopy)
        .then(() => {
            this.dispatchEvent(new ShowToastEvent({
                                                    title : 'Success',
                                                    messge: 'Data refreshed successfully',
                                                    variant:'success'
                                                })
                            );
        }).catch(() => {
            this.dispatchEvent(new ShowToastEvent({
                                                    title : 'SucErrorcess',
                                                    messge: 'Error while refreshing data',
                                                    variant: 'error'
                                                })
                                );
        });
    }
    selectedRecordIds = [];
    getSelectedRows(event){
        const selectedRows = event.detail.selectedRows;
        this.selectedRecordIds = selectedRows.map(row => row.Id);
        // Display that fieldName of the selected rows
        for (let i = 0; i < selectedRows.length; i++) {
            //this.selectedOpportunities = selectedRows;
            //alert('You selected: ' + selectedRows[i].Id);
        }
    }

    deleteAllRecords() {
        const deletePromises = this.selectedRecordIds.map(id => deleteRecord(id));

        Promise.all(deletePromises)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'All records deleted successfully',
                        variant: 'success'
                    })
                );
                // You can refresh data or navigate as needed here
                this.handelRefresh();
                this.selectedRecordIds = [];
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error deleting records',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }
}