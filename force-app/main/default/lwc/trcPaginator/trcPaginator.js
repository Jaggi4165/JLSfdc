import { LightningElement, api } from "lwc";


export default class TrcPaginator extends LightningElement {

/*import { loadScript, loadStyle } from "lightning/platformResourceLoader";
import jquery                    from "@salesforce/resourceUrl/jQuery";
import blade                     from "@salesforce/resourceUrl/bladePagination";*/
    @api itemsPerPage;

    _totalRecs;
    options;
    pageNumber = 1; // first page by default
    //jQuery;

    @api
    set totalRecs(value){
        this._totalRecs = value;
        //reset page number when totalRecs changed
        this.changePageNumber(1);
    }

    get totalRecs(){
        return this._totalRecs;
    }

    async connectedCallback() {
        /* NOTE: blade-pagination depends on jquery so make sure it loaded first*/
        /*await loadScript(this, jquery + "/jquery-3.4.1.min.js");
        await loadScript(this, blade + "/blade-pagination.js");
        await loadStyle(this, blade + "/blade-pagination.css");
        this.jQuery = jQuery;*/
        //this.initBladePagination();
    }

    renderedCallback() {
        //this.initBladePagination();
    }

    /*initBladePagination() {
        const ul = this.template.querySelector("ul");

        if (!ul || !this.jQuery) {
            return;
        }*/

        /* Build Pagination Component */
       /* this.jQuery(ul).bladePagination({
            maxPageNum: 5,
            firstLabel: "First",
            prevLabel: "Prev",
            nextLabel: "Next",
            lastLabel: "Last",
            moreLabel: "...",
            rebuildAfterClick: true,
            clickPage: (page, jqPagination) => {
                jqPagination.attr("data-current", page);
                this.changePageNumber(page);
            }
        });
    }*/

    get pagesAmount() {
        return Math.ceil(this.totalRecs / this.itemsPerPage);
    }

    get counterBegin() {
        return (this.pageNumber - 1) * this.itemsPerPage + 1;
    }

    get counterEnd() {
        return this.pageNumber * this.itemsPerPage > this.totalRecs ? this.totalRecs : this.pageNumber * this.itemsPerPage;
    }

    fireOnPageChangeEvent() {
        this.dispatchEvent(new CustomEvent("changepage", { detail: this.pageNumber }));
    }

    changePageNumber(page){
        this.pageNumber = page;
        this.fireOnPageChangeEvent();
    }

}