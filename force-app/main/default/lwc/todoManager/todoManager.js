import { LightningElement , wire } from 'lwc';
import getAccontList from '@salesforce/apex/AccountListControllerLwc.accountList';
export default class TodoManager extends LightningElement {
    @wire(getAccontList) todoList;
}