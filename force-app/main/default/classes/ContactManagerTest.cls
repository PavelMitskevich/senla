@isTest
public with sharing class ContactManagerTest {

    @isTest static void testCreateContact() {

        ContactManager.ContactWrapper wrapper = new ContactManager.ContactWrapper();
        wrapper.firstName = 'TestName';
        wrapper.lastName = 'TestLastName';
        wrapper.phone = '+375 29 555 55 55';
        wrapper.email = 'test@gmail.org';
        wrapper.recordType = 'Customer';

        Contact cMng = ContactManager.createContact(wrapper, true);

        System.assertEquals('TestName', cMng.FirstName);
    }
    
    @isTest static void testGetContactsByIds() {
        
        List<Contact> contacts = TestDataFactory.createContacts(5);       
        List<Id> testIdsList = new List<Id>();
        
        for(Integer i = 0; i < 5; i++) {
			testIdsList.add(contacts.get(i).Id);
        }

        List<Contact> contactsList = ContactManager.getContactsByIds(testIdsList, 'Name');

        System.assertEquals(5, contactsList.size());

    }
    
    @isTest static void testGetContactsByRecordTypes() {
        
        List<Contact> contacts = TestDataFactory.createContacts(5);   
        List<Contact> contactsList = ContactManager.getContactsByRecordType('Property Owner', 'Name');

        System.assertEquals(5, contactsList.size());

    }
    
    @isTest static void testUpdateContactsByIds() {
        
        List<Contact> contacts = TestDataFactory.createContacts(5);
        List<Id> testIdsList = new List<Id>();
        
        for(Integer i = 0; i<5; i++) {
            testIdsList.add(contacts.get(i).Id);
        }
        		
        ContactManager.ContactWrapper wrapper = new ContactManager.ContactWrapper();
        wrapper.firstName = 'TestName';
        wrapper.lastName = 'TestLastName';
        wrapper.phone = '+375 29 555 55 55';
        wrapper.email = 'test@gmail.org';

        List<Contact> cMngs = ContactManager.updateContactsByIds(testIdsList, wrapper, true);
		List<Contact> contactsFirstNames = [SELECT FirstName From Contact];
        
        System.assertEquals('TestName', contactsFirstNames.get(0).FirstName);
    }
    
    @isTest static void testDeleteContactsByPhones() {
        
        List<Contact> contacts = TestDataFactory.createContacts(5);
        List<String> testPhonesList = new List<String>();
        
        for(Integer i = 0; i<3; i++) {
            testPhonesList.add(contacts.get(i).Phone);
        }
        
        ContactManager.deleteContactsByPhones(testPhonesList);
        List<Contact> names = [SELECT Name FROM Contact];

        System.assertEquals(2, names.size());

    }
    
    @isTest static void testDeleteContactsRecordTypes() {

        List<Contact> contacts = TestDataFactory.createContacts(5);
        List<String> testRecordTypesList = new List<String>();
        testRecordTypesList.add('Property Owner');

        ContactManager.deleteContactsByRecordTypes(testRecordTypesList);
        List<Contact> names = [SELECT Name From Contact WHERE RecordType.Name =:'Property Owner'];

        System.assertEquals(0, names.size());

    }
}
