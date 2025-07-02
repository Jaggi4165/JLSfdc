import { LightningElement } from 'lwc';

export default class DataTableRowColor extends LightningElement {
    data = [
        { Id: '1', Name: 'Record 1', Status: 'Completed' },
        { Id: '2', Name: 'Record 2', Status: 'In Progress' },
        { Id: '3', Name: 'Record 3', Status: 'Not Started' }
    ];

    columns = [
        { label: 'Id', fieldName: 'Id', type: 'text' },
        { label: 'Name', fieldName: 'Name', type: 'text' },
        { label: 'Status', fieldName: 'Status', type: 'text', cellAttributes: { class: 'green-row' } }
    ];

    
    getRowClass(rowData) {
        return rowData.Status === 'Completed' ? 'green-row' : '';
      }

}