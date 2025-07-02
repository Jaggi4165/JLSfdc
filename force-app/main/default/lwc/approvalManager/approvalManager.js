import { LightningElement, track } from 'lwc';
import getSupportedObjects from '@salesforce/apex/UnifiedApprovalController.getSupportedObjects';
import getRecordsForObject from '@salesforce/apex/UnifiedApprovalController.getRecordsForObject';
import submitApproval from '@salesforce/apex/UnifiedApprovalController.submitApproval';
import getPendingApprovals from '@salesforce/apex/UnifiedApprovalController.getPendingApprovals';
import handleApprovalAction from '@salesforce/apex/UnifiedApprovalController.handleApprovalAction';
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

export default class ApprovalManager extends LightningElement {
    @track selectedObject;
    @track selectedRecord;
    @track objectOptions = [];
    @track recordOptions = [];
    @track approvalList = [];
    @track isLoading = false;

    columns = COLUMNS;

    connectedCallback() {
        getSupportedObjects().then(result => {
            this.objectOptions = result.map(obj => ({ label: obj, value: obj }));
        });
    }

    handleObjectChange(event) {
        this.selectedObject = event.detail.value;
        this.selectedRecord = null;
        this.recordOptions = [];

        getRecordsForObject({ objectName: this.selectedObject })
            .then(data => {
                this.recordOptions = data.map(rec => ({
                    label: rec.Name,
                    value: rec.Id
                }));
                this.fetchApprovals();
            });
    }

    handleRecordChange(event) {
        this.selectedRecord = event.detail.value;
    }

    submitApproval() {
        if (!this.selectedRecord) {
            this.showToast('Error', 'Please select a record', 'error');
            return;
        }
        submitApproval({ recordId: this.selectedRecord })
            .then(() => {
                this.showToast('Success', 'Approval submitted', 'success');
                this.fetchApprovals();
            }).catch(err => {
                this.showToast('Error', err.body.message, 'error');
            });
    }

    fetchApprovals() {
        if (!this.selectedObject) return;

        this.isLoading = true;
        getPendingApprovals({ objectName: this.selectedObject })
            .then(data => {
                this.approvalList = data;
                this.isLoading = false;
            }).catch(() => {
                this.showToast('Error', 'Error loading approvals', 'error');
                this.isLoading = false;
            });
    }

    handleRowAction(event) {
        const action = event.detail.action.name;
        const row = event.detail.row;

        handleApprovalAction({
            workitemId: row.workitemId,
            actionName: action === 'approve' ? 'Approve' : 'Reject',
            comments: `${action} via LWC`
        }).then(() => {
            this.showToast('Success', `Request ${action}d successfully`, 'success');
            this.fetchApprovals();
        }).catch(() => {
            this.showToast('Error', `Failed to ${action} request`, 'error');
        });
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}