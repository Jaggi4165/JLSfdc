import LightningDatatable from 'lightning/datatable';
import imageTableControl from './imageTableControl.html';

export default class TrcCustomDataTable extends LightningDatatable {
    static customTypes = {
        image: {
            template: imageTableControl
        }
    };
}