@isTest
public with sharing class ContactManagerTest {

    @isTest static void testCreateContact() {

        ContactManager.ContactWrapper wrapper = new ContactManager.ContactWrapper();
        wrapper.firstName = 'TestName';
        wrapper.lastName = 'TestLastName';
        wrapper.phone = '+375 29 555 55 55';
        wrapper.email = 'test@gmail.org';

        Contact cMng = ContactManager.createContact(wrapper, true);

        System.assertEquals('TestName', cMng.FirstName);
    }

    @isTest static void testGetContactsByIds() {

        List<Id> testIdsList = new List<Id>();
        testIdsList.add('0035i00000EHcLcAAL');
        testIdsList.add('0035i00000EHwhHAAT');

        List<Contact> contactsList = ContactManager.getContactsByIds(testIdsList, 'Name');

        System.assertEquals('Carol Ruiz', contactsList.get(0).Name);

    }

    @isTest static void testGetContactsByRecordTypes() {

        List<Contact> contactsList = ContactManager.getContactsByIds('Property Owner', 'Name');

        System.assertEquals('Carol Ruiz', contactsList.get(0).Name);

    }

    @isTest static void testUpdateContactsByIds() {

        List<Id> testIdsList = new List<Id>();
        testIdsList.add('0035i00000EHwhIAAT');
        testIdsList.add('0035i00000EHwhJAAT');

        ContactManager.ContactWrapper wrapper = new ContactManager.ContactWrapper();
        wrapper.firstName = 'TestName';
        wrapper.lastName = 'TestLastName';
        wrapper.phone = '+375 29 555 55 55';
        wrapper.email = 'test@gmail.org';

        List<Contact> cMngs = ContactManager.updateContactsByIds(testIdsList, wrapper, true);

        System.assertEquals('TestName', cMngs.get(0).Name);

    }

    @isTest static void testDeleteContactsByPhones() {

        List<String> testPhonesList = new List<String>();
        testPhonesList.add('(415)555-1212');
        testPhonesList.add('11111');

        ContactManager.deleteContactsByPhones(testPhonesList);

        System.assertEquals(null, [SELECT Phone From Contact WHERE Phone =: '11111']);

    }

    @isTest static void testDeleteContactsRecordTypes() {

        List<String> testRecordTypesList = new List<String>();
        testRecordTypesList.add('Broker');
        testRecordTypesList.add('Customer');

        ContactManager.deleteContactsByRecordTypes(testRecordTypesList);

        System.assertEquals(null, [SELECT Phone From Contact WHERE RecordType.Name IN :'Broker']);

    }


}
