import { LightningElement,track,wire } from 'lwc';
import getSupportedObjects from '@salesforce/apex/GenericApprovalProcessController.getSupportedObjects';
import getPendingApprovals from '@salesforce/apex/GenericApprovalProcessController.getPendingApprovals';
import handleApprovalAction from '@salesforce/apex/GenericApprovalProcessController.handleApprovalAction';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
const ACTIONS = [
    { label: 'Approve', name: 'approve' },
    { label: 'Reject', name: 'reject' }
];

const COLUMNS = [
    { label: 'Record Name', fieldName: 'recordName' },
    { label: 'Created Date', fieldName: 'createdDate', type: 'date' },
    {
        type: 'action',
        typeAttributes: { rowActions: ACTIONS }
    }
];
export default class CaseRequestComponent extends LightningElement {
    @track objectOptions = [];
    @track selectedObject;
    @track approvalList = [];
    @track isLoading = false;

    columns = COLUMNS;

    connectedCallback() {
        getSupportedObjects()
            .then(result => {
                this.objectOptions = result.map(obj => ({
                    label: obj,
                    value: obj
                }));
            });
    }

    handleObjectChange(event) {
        this.selectedObject = event.detail.value;
        this.fetchApprovals();
    }

    fetchApprovals() {
        this.isLoading = true;
        getPendingApprovals({ sObjectName: this.selectedObject })
            .then(data => {
                this.approvalList = data;
                this.isLoading = false;
            })
            .catch(error => {
                this.showToast('Error', error.body.message, 'error');
                this.isLoading = false;
            });
    }

    handleRowAction(event) {
        const action = event.detail.action.name;
        const row = event.detail.row;
        const workitemId = row.workitemId;
        alert(` request on ${row.recordName} (${row.recordId})`);
        handleApprovalAction({
            workitemId: workitemId,
            actionName: action === 'approve' ? 'Approve' : 'Reject',
            comments: `${action} via LWC`
        }).then(() => {
            this.showToast('Success', `Request ${action}d successfully`, 'success');
            this.fetchApprovals();
        }).catch(error => {
            this.showToast('Error', `Failed to ${action} request`, 'error');
        });
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}