public inherited sharing class CommissionsPercentManager {

    public class CommissionsPercentWrapper {
        
        public String comission {get; set;}
        public Id dealId {get; set;}
        public Id brokerId {get; set;}
    }

    public static Commissions_Percent__c createCommissionsPercent(CommissionsPercentWrapper wrapper, Boolean serialize) {
        
        Commissions_Percent__c commissionsPercent = new Commissions_Percent__c();

        commissionsPercent.Commission__c = Decimal.valueOf(wrapper.comission);
        commissionsPercent.Commission_Deal__c = wrapper.dealId;
        commissionsPercent.Commission_Broker__c = wrapper.brokerId;

        if(serialize) insert commissionsPercent;

        return commissionsPercent;
    }

    public static List<Commissions_Percent__c> getCommissionPercentByIds(List<Id> id, String fields) {

        return Database.query('SELECT ' + fields + ' FROM Commissions_Percent__c WHERE Id IN :ids');
    }

    public static List<Commissions_Percent__c> updateCommissionsPercents(List<Id> ids, Decimal comission, Boolean serialize) {

        List<Commissions_Percent__c> commissionsPercents =
                                    [SELECT Brokers_Percent__c FROM Commissions_Percent__c WHERE Id IN :ids];

        List<Commissions_Percent__c> updatedCommissionsPercents = new List<Commissions_Percent__c>();

        for (Commissions_Percent__c commissionsPercent : commissionsPercents) {
            commissionsPercent.Commission__c = comission;
            updatedCommissionsPercents.add(commissionsPercent);
        }

        if(serialize) update updatedCommissionsPercents;

        return updatedCommissionsPercents;
    }

    public static void deleteCommissionPercentsByCommission(List<Decimal> comissions) {

        delete [SELECT Id FROM Commissions_Percent__c WHERE Brokers_Percent__c IN :comissions];
    }
}
