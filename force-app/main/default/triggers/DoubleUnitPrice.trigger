trigger DoubleUnitPrice on Merchandise__c (after update) {
    if(trigger.isAfter && trigger.isUpdate) {
        DoubleUnitPriceClass.unitPrice(trigger.New);
    }
}