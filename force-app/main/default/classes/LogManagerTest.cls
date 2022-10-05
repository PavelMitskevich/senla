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

}
