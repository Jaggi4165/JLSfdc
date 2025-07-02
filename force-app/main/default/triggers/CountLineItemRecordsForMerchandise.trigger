trigger CountLineItemRecordsForMerchandise on Line_Item__c (after insert, after delete) {
    if(trigger.isInsert && trigger.isAfter) {
        CountLineItemsRecords.countLineItems(trigger.New);
    }
    
    if(trigger.isDelete && trigger.isAfter) {
        CountLineItemsRecords.countLineItemsPart2(trigger.Old);
    }
}