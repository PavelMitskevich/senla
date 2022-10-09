@isTest
private class DealManagerTest {

    @isTest static void testCreateDeal() {
        
        List<Contact> contacts = TestDataFactory.createContacts(2);
        
        PropertyManager.PropertyWrapper propWrapper = new PropertyManager.PropertyWrapper();
        propWrapper.address = 'Test Address';
        propWrapper.sellingPrice = 250000;
        propWrapper.propertyOwner = contacts.get(1).Id;

        Property__c prop = PropertyManager.createProperty(propWrapper, true);

        DealManager.DealWrapper wrapper = new DealManager.DealWrapper();
        
        wrapper.property = prop.Id;
        wrapper.buyer = contacts.get(0).Id;
        wrapper.seller = contacts.get(1).Id;
        wrapper.status = 'Open';
        wrapper.recordType = 'Sale';


        Deal__c deal = DealManager.createDeal(wrapper, true);

        System.assertEquals('Open', deal.Status__c);
    }

    @isTest static void testGetDealsByIds() {
        
        List<Deal__c> deals = TestDataFactory.createDeals(5);
        List<Id> testIdsList = new List<Id>();
        
        for(Integer i = 0; i < 3; i++) {
            testIdsList.add(deals.get(i).Id);
        }
        
        List<Deal__c> dealsList = DealManager.getDealsByIds(testIdsList, 'Name');

        System.assertEquals(3, dealsList.size());
    }

    @isTest static void testGetDealsByStatus() {
        
        List<Deal__c> deals = TestDataFactory.createDeals(5);
        List<Deal__c> dealsList = DealManager.getDealsByStatus('Open', 'Status__c, Name');
        
        System.assertEquals(5, dealsList.size());
    }
    
    @isTest static void testUpdateDealsByIds() {
        
        List<Deal__c> deals = TestDataFactory.createDeals(5);
        List<Id> testIdsList = new List<Id>();
        
        for(Integer i = 0; i<3; i++) {
            testIdsList.add(deals.get(i).Id);
        }
		
        Deal__c deal = TestDataFactory.createDeal();
        DealManager.DealWrapper wrapper = new DealManager.DealWrapper();
        wrapper.property = deal.Property__c;
        wrapper.buyer = deal.Buyer__c;
        wrapper.seller = deal.Seller__c;

        List<Deal__c> dealsUpd = DealManager.updateDealsByIds(testIdsList, wrapper, true);

        System.assertEquals(3, dealsUpd.size());

    }

    @isTest static void testDeleteDealsByStatus() {
        
        List<Deal__c> deals = TestDataFactory.createDeals(5);

        DealManager.deleteDealsByStatus('Open');
        List<Deal__c> dealsDel = [SELECT Name From Deal__c WHERE Status__c =:'Open'];
        
        System.assertEquals(0, dealsDel.size());
    }      
}
