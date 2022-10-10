public inherited sharing class DealManager {

    private static final String DEFAULT_RECORD_TYPE = 'Sale';

    public static final String DEFAULT_STATUS = 'Awaiting Approval';

    public static final Id SALE_RECORD_TYPE_ID = '0125i000000xyM8AAI';

    public class DealWrapper {
        public Id property {get; set;}
        public Id buyer {get; set;}
        public Id seller {get; set;}
        public String status {get; set;}
        public String recordType {get; set;}
    }

    public static Deal__c createDeal(DealWrapper wrapper, Boolean serialize) {
        Deal__c deal = new Deal__c();
        Property__c prop = PropertyManager.getPropertyById(wrapper.property, 'Owner__c');
        deal.Seller__c = prop.Owner__c;
        deal.Buyer__c = wrapper.buyer;     
        deal.Property__c = wrapper.property;
        if(wrapper.recordType == 'Sale' || wrapper.recordType == null){
            deal.RecordType = [SELECT id FROM RecordType WHERE Name = 'Sale'];
        } else if (wrapper.recordType == 'Lease') {
            deal.RecordType = [SELECT id FROM RecordType WHERE Name = 'Lease'];
        }
        deal.Status__c = String.isNotBlank(wrapper.status) ? wrapper.status : DEFAULT_STATUS;

        if (serialize) insert deal;

        return deal;
    }

    public static List<Deal__c> getDealsByIds(List<Id> ids, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Deal__c WHERE Id IN :ids');
    }

    public static List<Deal__c> getDealsByStatus(String status, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Deal__c WHERE Status__c = :status');
    }

    public static List<Deal__c> updateDealsByIds(List<Id> ids, DealWrapper wrapper, Boolean serialize) {
        List<Deal__c> dealsList = [SELECT Buyer__c, Property__c, Status__c FROM Deal__c WHERE Id IN :ids];
        List<Deal__c> updatedDealsList = new List<Deal__c>();

        for(Deal__c deal : dealsList) {
            deal.Buyer__c = wrapper.buyer;
            deal.Seller__c = wrapper.seller;
            deal.Property__c = wrapper.property;
            deal.Status__c = (String.isNotBlank(wrapper.status)) ? wrapper.status : DEFAULT_STATUS;
            updatedDealsList.add(deal);
        }

        if (serialize) update updatedDealsList;

        return updatedDealsList;
    }

    public static void deleteDealsByStatus(String status) {
        delete [SElECT Id FROM Deal__c WHERE Status__c = :status];
    }

    public static List<Deal__c> getNotClosedSaleDealsByProperties(List<Id> propertyIds) {
    return [
            SELECT Id
            FROM Deal__c
            WHERE Property__c IN :propertyIds
            AND Status__c NOT IN ('Closed Won', 'Closed', 'Closed Lost')
            AND RecordTypeId = :SALE_RECORD_TYPE_ID
    ];
    }
}
