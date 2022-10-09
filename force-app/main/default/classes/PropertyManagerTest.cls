@isTest
private class PropertyManagerTest {

    @isTest static void testCreateProperty() {

        Contact cont = TestDataFactory.createContact('Test FN', 'Test LN');
        
        PropertyManager.PropertyWrapper wrapper = new PropertyManager.PropertyWrapper();
        wrapper.address = 'Test Address';
        wrapper.sellingPrice = 250000;
        wrapper.propertyOwner = cont.Id;

        Property__c prop = PropertyManager.createProperty(wrapper, true);

        System.assertEquals('Test Address', prop.Address__c);        
    }
    
    @isTest static void testGetPropertiesByIds() {
        
        List<Property__c> properties = TestDataFactory.createProperties(5);       
        List<Id> testIdsList = new List<Id>();
        
        for(Integer i = 0; i < properties.size(); i++) {
			testIdsList.add(properties.get(i).Id);
        }

        List<Property__c> propertiesList = PropertyManager.getPropertiesByIds(testIdsList, 'Name');

        System.assertEquals(5, propertiesList.size());
    }
    
    @isTest static void testGetPropertyById() {
        
        List<Property__c> properties = TestDataFactory.createProperties(5);       
        Id propId = properties.get(0).Id;
        
        Property__c property = PropertyManager.getPropertyById(propId, 'Address__c, RecordType.Name ');

        System.assertEquals('Test Address 0', property.Address__c);
    }    
    
    @isTest static void testGetPropertiesBySellingPrices() {
        
        List<Property__c> properties = TestDataFactory.createProperties(5);
        List<Decimal> sellingPrices = new List<Decimal>();
        
        for(Integer i = 0; i < 3; i++) {
            sellingPrices.add(properties.get(i).Selling_Price__c);
        }
        
        List<Property__c> propertiesList = PropertyManager.getPropertiesBySellingPrices(sellingPrices, 	'Selling_Price__c');
        
        System.assertEquals(3, propertiesList.size());
    }

    @isTest static void testUpdateContactsByIds() {
        
        List<Property__c> properties = TestDataFactory.createProperties(5);
        List<Id> testIdsList = new List<Id>();
        Contact cont = TestDataFactory.createContact('Update FN', 'Update LN');
        
        for(Integer i = 0; i<5; i++) {
            testIdsList.add(properties.get(i).Id);
        }
        
        PropertyManager.PropertyWrapper wrapper = new PropertyManager.PropertyWrapper();
        wrapper.address = 'Test Address Wrapper';
        wrapper.rentPrice = 150;
        wrapper.sellingPrice = 50000;
        wrapper.propertyOwner = cont.Id;
        
        List<Property__c> propertiesList = PropertyManager.updatePropertiesByIds(testIdsList, wrapper, true);
		List<Property__c> propertiesAddress = [SELECT Address__c From Property__c];
        
        System.assertEquals('Test Address Wrapper', propertiesAddress.get(0).Address__c);
    }

    @isTest static void testDeletePropertiesByPropertyOwners() {
        
        List<Property__c> properties = TestDataFactory.createProperties(5);
        List<Id> contactsList = new List<Id>();
        
        for(Integer i = 0; i < 3; i++) {
            Id ct = properties.get(i).Owner__c;
            contactsList.add(ct);
        }
        
        PropertyManager.deletePropertiesByPropertyOwners(contactsList);
        List<Property__c> propertiesAddress = [SELECT Address__c From Property__c];
        
        System.assertEquals(2, propertiesAddress.size());
    }  
}
