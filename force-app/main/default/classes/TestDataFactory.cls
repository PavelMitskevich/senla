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
            Contact contact = new Contact(FirstName = 'FN ' + i, LastName = 'Test ' + i, Phone = '1212' + i);
            contacts.add(contact);
        }

        insert contacts;
        return contacts;
    }

    public static Log__c createLog() {

        Log__c log = new Log__c(Type__c = 'DEBUG', Message__c = 'DEBUG Log is created');

        insert log;
        return log;
    }

    public static Property__c createProperty(String address) {
        
        Contact owner = TestDataFactory.createContact('Owner First Name', 'Owner Last Name');

        Property__c property = new Property__c(Address__c = address, Owner__c = owner.Id);

        insert property;
        return property;
    }

    public static List<Property__c> createProperties(Integer num) {

        List<Property__c> properties = new List<Property__c>();
		List<Contact> contacts = TestDataFactory.createContacts(num);
        
        for (Integer i = 0; i < num; i++) {
            Property__c property = new Property__c(Address__c = 'Test Address ' + i, Owner__c = contacts.get(i).Id, Selling_Price__c = 20000 + i*100);
            properties.add(property);
        }

        insert properties;
        return properties;
    }

    public static Deal__c createDeal() {
        
        Contact buyer = TestDataFactory.createContact('Buyer First Name', 'Buyer Last Name');       
        Property__c property = TestDataFactory.createProperty('Kupala str.');

        Deal__c deal = new Deal__c(Property__c = property.Id, Buyer__c= buyer.Id, Seller__c = property.Owner__c);

        insert deal;
        return deal;
    }
    
    public static List<Deal__c> createDeals(Integer num) {

        List<Deal__c> deals = new List<Deal__c>();
        List<Property__c> properties = TestDataFactory.createProperties(num);

        for (Integer i = 0; i < num; i++) {
                
            Contact buyer = TestDataFactory.createContact('Buyer First Name' + i, 'Buyer Last Name' + i);
         	Deal__c deal = new Deal__c(Property__c = properties.get(i).Id, Buyer__c = buyer.Id, Seller__c = properties.get(i).Owner__c);
            deals.add(deal);
        }

            insert deals;
            return deals;
    }
}