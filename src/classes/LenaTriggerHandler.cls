public class LenaTriggerHandler { 
    private static final Set<String> fieldsToMap = new Set <String>{'Phone', 'Description'};
    
        //protected void beforeUpdate(){
        //List<Lead> leadsForUpdate = getleadsToUpdate(Trigger.oldMap, Trigger.newMap);
    //} 
    
    private List <Lead> getleadsToUpdate(Map<Id,Sobject> oldMap, Map<Id,Sobject> newMap){
        List<Lead> leadToUpdate = new List <Lead>();
        for (Id leadId:oldMap.keySet()){
            Sobject oldLead = oldMap.get(LeadId);
            Sobject newLead = newMap.get(LeadId);
            if ((Boolean) oldLead.get('isConvert')&&(Boolean) newLead.get('isConvert')){ 
                for(String fieldToCheck:fieldsToMap){ 
                    if((oldLead.get(fieldToCheck) != newLead.get(fieldToCheck))){ 
                        leadToUpdate.add((Lead) newLead);
                    }
                }
                //return leadToUpdate;
            }  
        } 
        return leadToUpdate;
        // private void AddEvents(String textPlatformEvent){ 
        // List<LeadChanged__e> event = new List <LeadChanged__e> ();
        // event.add(new LeadChanged__e(RawData__c = textPlatformEvent ));
        // }
        // List<Database.SaveResultEvent> results = EventBus.publish(event);
	}
}