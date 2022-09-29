public inherited sharing class PropertyManager {

    private static final String DEFAULT_RECORD_TYPE = 'Industrial';

    public class PropertyWrapper {

        public String address {get; set;}
        public Decimal rentPrice {get; set;}
        public Decimal sellingPrice {get; set;}
        public Id propertyOwner {get; set;}
        public String recordType {get; set;}
    }

    public static Property__c createProperty(PropertyWrapper wrapper, Boolean serialize) {

        Property__c property = new Property__c();
        
        property.Address__c = wrapper.address;
        property.Rental__c = wrapper.rentPrice;
        property.Selling_Price__c = wrapper.sellingPrice;
        property.Owner__c = wrapper.propertyOwner;
        property.RecordType = (String.isNotBlank(wrapper.recordType)) ? wrapper.recordType : DEFAULT_TYPE;

        if(serialize) insert property;

        return property;
    }

    public static List<Property__c> getPropertiesByIds(List<Id> ids, String fields) {

        return Database.query('SELECT ' + fields + ' FROM Property__c WHERE Id IN :ids');
    }

    public static List<Property__c> getPropertiesBySoldPrices(List<Decimal> soldPrices, String fields) {

        return Database.query('SELECT ' + fields + ' FROM Property__c WHERE Sold_Price__c IN :soldPrices');
    }

    public static List<Property__c> updateContactsByIds(List<Id> ids, PropertyWrapper wrapper, Boolean serialize) {

        List<Property__c> propertiesList =
            [SELECT Address__c, Rental__c, Selling_Price__c, Owner__c FROM Property__c WHERE Id IN :ids];

        List<Property__c> updatedPropertiesList = new List<Property__c>();

        for (Property__c property : updatedPropertiesList) {
            property.Address__c = wrapper.address;
            property.Rental__c = wrapper.rentPrice;
            property.Selling_Price__c = wrapper.sellingPrice;
            property.Owner__c = wrapper.propertyOwner;
            property.RecordType = (String.isNotBlank(wrapper.recordType)) ? wrapper.recordType : DEFAULT_TYPE;
            updatedPropertiesList.add(property);
        }

        if (serialize) update updatedPropertiesList;

        return updatedPropertiesList;
    }

    public static void deletePropertiesByPropertyOwners(List<Id> propertyOwners) {

        delete [SELECT Id FROM Property__c WHERE Owner__c IN :propertyOwners];
    }
}
