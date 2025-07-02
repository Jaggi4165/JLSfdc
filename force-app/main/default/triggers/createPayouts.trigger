trigger createPayouts on Incentive__c (after update){ 
    BuildingBlocksIncentiveController.payoutRecordsCreate(trigger.new,trigger.old); 
}