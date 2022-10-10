@IsTest
public with sharing class DealTriggerHandlerTest {

    @IsTest static void testTriggerHandler() {

        List<Deal__c> deals = TestDataFactory.createDeals(3);
        Deal__c firstDeal = deals.get(0);
        Deal__c secondDeal = deals.get(1);
        Deal__c thirdDeal = deals.get(2);
        firstDeal.Status__c = 'Closed Won';

        update firstDeal;

        System.assertEquals('Closed Lost', [SELECT Status__c FROM Deal__c
                                            WHERE Status__c = 'Closed Lost'
                                            AND Property__c =: secondDeal.Property__c].Status__c);
    }
}
