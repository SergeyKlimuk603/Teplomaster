trigger Opportunity on Opportunity (before insert, before update, after update) {
	new OpportunityTriggerHandler().execute();
}