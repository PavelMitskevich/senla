@isTest
private class LogManagerTest {

    @isTest static void testCreateLog() {

        LogManager.LogWrapper wrapper = new LogManager.LogWrapper();
        wrapper.logType = 'Test Log';
        wrapper.message = 'Test message';

        Log__c lg = LogManager.createLog(wrapper, true);

        System.assertEquals('Test message', lg.Message__c);
    }

    @isTest static void testGetLogsByIds() {

        Log__c lg = TestDataFactory.createLog();
        List<Id> testIdsList = new List<Id>();
        testIdsList.add(lg.Id);
        
        List<Log__c> logsList = LogManager.getLogsByIds(testIdsList, 'Message__c');

        System.assertEquals('DEBUG Log is created', logsList.get(0).Message__c);

    }
    
    @isTest static void testGetLogsByTypes() {
        
        Log__c lg = TestDataFactory.createLog();
  		List<String> types = new List<String>();
        types.add('DEBUG');
        
        List<Log__c> logsList = LogManager.getLogsByTypes(types, 'Type__c');
        
        System.assertEquals(1, logsList.size());
    }

    @isTest static void testUpdateLogsByIds() {
        
        Log__c lg = TestDataFactory.createLog();
        List<Id> testIdsList = new List<Id>();
        testIdsList.add(lg.Id);
        
        LogManager.LogWrapper wrapper = new LogManager.LogWrapper();
        wrapper.logType = 'Test Log';
        wrapper.message = 'Test message';
        
        List<Log__c> logsUpd = LogManager.updateLogsByIds(testIdsList, wrapper, true);
        List<Log__c> logsType = [SELECT Type__c From Log__c];
        
        System.assertEquals('Test Log', logsType.get(0).Type__c);
    }
    
    @isTest static void testUpdateLogById() {
        
        Log__c lg = TestDataFactory.createLog();
        Id testId = lg.Id;
        
        LogManager.LogWrapper wrapper = new LogManager.LogWrapper();
        wrapper.logType = 'Test Log';
        wrapper.message = 'Test message';
        
        Log__c logsUpd = LogManager.updateLogById(testId, wrapper, true);
        Log__c logTypeUpd = [SELECT Type__c From Log__c];
        
        System.assertEquals('Test Log', logTypeUpd.Type__c);
    }
    
    @isTest static void testDeleteLogsByIds() {
        Log__c lg = TestDataFactory.createLog();
        Log__c lg2 = TestDataFactory.createLog();
        Log__c lg3 = TestDataFactory.createLog();
        
        LogManager.LogWrapper wrapper = new LogManager.LogWrapper();
        wrapper.logType = 'ERROR';
        wrapper.message = 'Test message';
        
        Log__c logsUpd = LogManager.updateLogById(lg3.Id, wrapper, true);
        
        List<String> types = new List<String>();
        types.add(lg.Type__c);
        
        LogManager.deleteLogsByTypes(types);
        List<Log__c> logTypes = [SELECT Type__c From Log__c];

        System.assertEquals(1, logTypes.size());
    }
}
