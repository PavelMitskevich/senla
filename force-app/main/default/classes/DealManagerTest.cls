@isTest
private class DealManagerTest {

    @isTest static void testCreateDeal() {

        DealManager.DealWrapper wrapper = new DealManager.DealWrapper();
        wrapper.property = 'Test Property';
        wrapper.buyer = '0035i00000EHwhIAAT';
        wrapper.seller = '0035i00000CQvUgAAL';
        wrapper.status = 'Open';
        wrapper.recordType = 'Sale';

        Deal__c deal = DealManager.createDeal(wrapper, true);

        System.assertEquals('Awaiting Approval', deal.Status__c);
    }

    @isTest static void testGetDealsByIds() {

        List<Id> testIdsList = new List<Id>();
        testIdsList.add('a015i00000Xp6ypAAB');

        List<Deal__c> dealsList = DealManager.getDealsByIds(testIdsList, 'Name');

        System.assertEquals('D-0001', dealsList.get(0).Name);
    }

    @isTest static void testGetDealsByStatuses() {

        List<Deal__c> dealsList = DealManager.getDealsByStatuses(new List<String>{'Awaiting Approval'}, 'Name');
        System.assertEquals(1, dealsList.size());
    }

    @isTest static void testUpdateDealsByIds() {

        List<Id> testIdsList = new List<Id>();
        testIdsList.add('a015i00000Xp6ypAAB');

        DealManager.DealWrapper wrapper = new DealManager.DealWrapper();
        wrapper.property = 'Test Property2';
        wrapper.buyer = 'Test Buyer2';
        wrapper.seller = 'Test Seller2';

        List<Deal__c> deals = DealManager.updateDealsByIds(testIdsList, wrapper, true);

        System.assertEquals('Test Property2', deals.get(0).Property__c);

    }

    @isTest static void testDeleteDealsByStatus() {

        List<String> testStatusesList = new List<String>();
        testStatusesList.add('Open');

        DealManager.deleteDealsByStatus(testStatusesList);

        System.assertEquals(null, [SELECT Name From Deal__c WHERE RecordType.Name =:'Open']);

    }

}
