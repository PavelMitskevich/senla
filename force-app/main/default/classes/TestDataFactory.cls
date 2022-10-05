@IsTest
public with sharing class TestDataFactory {

    public static Contact createContact(String firstName, String lastName) {

        Contact contact = new Contact(FirstName = firstName, LastName = lastName);

        insert contact;
        return contact;
    }

    public static List<Contact> createContacts(Integer num) {

        List<Contact> contacts = new List<Contact>();

        for (Integer i = 0; i < num; i++) {
            Contact contact = new Contact(FirstName = 'FN ' + i, LastName = 'Test ' + i);
        }

        insert contacts;
        return contacts;
    }

    public static Log__c createLog() {

        Log__c log = new Log__c(Type__c = 'DEBUG', Message__c = 'DEBUG Log is created');

        insert log;
        return log;
    }

    public static Deal__c createDeal() {
        
        Contact buyer = TestDataFactory.createContact('Buyer First Name', 'Buyer Last Name');
        
        Contact seller = TestDataFactory.createContact('Seller First Name', 'Seller Last Name');
        
        Property__c property = TestDataFactory.createProperty('Kupala str.');

        Deal__c deal = new Deal__c(Property__c = property.Id, Buyer__c= buyer.Id, Seller__c = seller.Id);

        insert deal;
        return deal;
    }

    public static List<Deal__c> createDeals(List<Property__c> properties, List<Buyer__c> buyers, List<Seller__c> sellers) {

        if(properties.size() == buyers.size() && properties.size() == sellers.size()) {

            List<Deal__c> deals = new List<Deal__c>();

            for (Integer i = 0; i < properties.size(); i++) {
                Deal__c deal = new Deal__c(Property__c = properties[i], Buyer__c = buyers[i], Seller__c = sellers[i]);
            }

            insert deals;
            return deals;
        } else {
            return null;
        }
    }

    public static Property__c createProperty(String address) {
        
        Contact owner = TestDataFactory.createContact('Seller First Name', 'Seller Last Name');

        Property__c property = new Property__c(Address__c = address, Owner__c = owner.Id);

        insert property;
        return property;
    }

    public static List<Property__c> createDeals(List<Owner__c> owners) {

            List<Property__c> properties = new List<Property__c>();

            for (Integer i = 0; i < owners.size(); i++) {
                Property__c property = new Property__c(Address__c = 'Test Address ' + i, Owner__c = owners[i]);
            }

            insert properties;
            return properties;
   }



}