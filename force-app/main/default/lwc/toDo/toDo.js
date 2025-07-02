import { LightningElement ,track} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ToDo extends LightningElement {

    @track listOfTasks = [];
    @track listOfDeletedTasks =[];
    addToDoList(){

        const task1 = this.template.querySelector("lightning-input").value;
        if(task1 != null){
            // check for duplicates
                this.listOfTasks.push(task1);
            }
        else {
            alert('tasks null');
           
        } 
    }
    deleteTask(event) {
        const delTask = event.target.value; 
        const jjj = this.template.querySelector("class-item").value
        this.listOfDeletedTasks.push(jjj);

        this.listOfTasks.pop(jjj);

    }
}