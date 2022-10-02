
public with sharing class TestObjectUpdateEventTriggerHandler extends TriggerHandler {

    protected override void afterInsert(Map<Id, sObject> newMap) {
        update createTestObjectsForUpdate(newMap.values());
    }

    private List<TestObject__c> createTestObjectsForUpdate(List<TestObjectUpdatedEvent__e> newList) {
        List<TestObject__c> testObjectsForUpdate = new List<TestObject__c>();

        for (TestObjectUpdatedEvent__e testObjectUpdateEvent : newList) {
            testObjectsForUpdate.add(
                    new TestObject__c(
                            Id = testObjectUpdateEvent.TestObjectId__c,
                            IsLastUpdateSuccessful__c = testObjectUpdateEvent.IsSuccessfulUpdate__c
                    )
            );
        }

        return testObjectsForUpdate;
    }
}