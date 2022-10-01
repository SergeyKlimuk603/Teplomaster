public class TestLockdown {
	@AuraEnabled
    public static Lockdown__mdt getLockdown() {
        List<Lockdown__mdt> lockdownList = [SELECT Id, Start_lockdown__c, End_lockdown__c 
                                            FROM Lockdown__mdt 
                                            LIMIT 100];
        Lockdown__mdt lockdown;
        for (Lockdown__mdt item : lockdownList) {
            System.debug('item:' + item);
            if (item.Start_lockdown__c != null && item.End_lockdown__c != null) {
                lockdown = item;
                break;
            }
        }
        return lockdown;
    }
    
   
    
}