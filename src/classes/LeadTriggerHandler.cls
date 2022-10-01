public class LeadTriggerHandler extends TriggerHandler {
    protected override void beforeUpdate(List<sObject> newList, Map<Id, sObject> oldMap) {
        markConvertingLeads((Map<Id, Lead>) oldMap, (List<Lead>) newList);
    }
    
    private void markConvertingLeads(Map<Id, Lead> oldMap, List<Lead> newList) {
        System.debug('oldMap = ' + oldMap);
        System.debug('newList = ' + newList);
        for (Lead newLead : newList) {
            Lead oldLead = oldMap.get(newLead.Id);
            if (!oldLead.IsConverted && newLead.IsConverted) {
                newLead.NeedToProcess__c = true;
            }
        }    
    }
}