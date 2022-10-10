trigger DealChangeStatusTrigger on Deal__c (after update) {

    new DealTriggerHandler().run();

}