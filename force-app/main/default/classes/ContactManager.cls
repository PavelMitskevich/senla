public inherited sharing class ContactManager {

    private static final String DEFAULT_RECORD_TYPE = 'Property Owner';

    public class ContactWrapper {
        public String name {get; set;}
        public String lastName{get; set}
        public String phone {get; set}
        public String recordType {get; set;}
        public String email {get; set;}
    }
 
    public static Contact createContact(ContactWrapper wrapper, Boolean serialize) {
        Contact contact = new Contact();
        contact.Name = wrapper.Name;
        contact.Phone = wrapper.phone;
        contact.Email = wrapper.email;
        contact.RecordType = (String.isNotBlank(wrapper.recordType)) ? wrapper.recordType : DEFAULT_TYPE;
        
        if (serialize) insert contact;

        return contact;
    }

    public static List<Contact> getContactsByIds(List<Id> ids, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Contact WHERE Id IN :ids');
    }

    public static List<Contact> getContactsByRecordTypes(List<Id> recordTypes, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Contact WHERE RecordTypeId IN :recordTypes');
    }

    public static List<Contact> updateContactsByIds(List<Id> ids, ContactWrapper wrapper, Boolean serialize) {
        List<Contact> contactsList = [SELECT First_Name__c, Last_Name__c, RecordTypeId, Phone, Email FROM Contact WHERE Id IN :ids];
        List<Contact> updatedContactsList = new List<Contact>();

        for (Contact contact : contactsList) {
            contact.Name = wrapper.Name;
            contact.RecordType = (String.isNotBlank(wrapper.recordType)) ? wrapper.recordType : DEFAULT_TYPE;
            contact.Phone = wrapper.phone;
            contact.Email = wrapper.email;
            updatedContactsList.add(contact);
        }

        if (serialize) update updatedContactsList;

        return updatedContactsList;
    }

    public static void deleteContactsByIds(List<String> phones) {
            delete [SELECT Id FROM Contact WHERE Phone IN :phones];
    }
 

    public static void deleteContactsByRecordTypes(List<String> recordTypes) {
        delete [SELECT Id FROM Contact WHERE RecordType.Name IN :recordTypes];
    }


}
