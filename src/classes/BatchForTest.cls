public with sharing class BatchForTest implements Database.Batchable<SObject>, Database.Stateful, Schedulable {

    Integer chunkNumber = 0;
    Integer val;
    Integer chunkDelay;
    Integer startDelay;

    public BatchForTest () {
    }

    public BatchForTest (Integer val, Integer startDelay, Integer chunkDelay) {
        this.val = val;
        this.startDelay = startDelay;
        this.chunkDelay = chunkDelay;
    }

    //Schedulable
    public void execute(SchedulableContext schedulableContext) {
        Database.executeBatch(new BatchForTest());
    }
    
    public void execute(Database.BatchableContext param1, List<TestObject__c> testObjects) {
        chunkNumber++;
        //System.debug('-----testObjects: ' + testObjects);
        System.debug('-----chunkNumber: ' + chunkNumber);
        System.debug('-----val: ' + val);
        System.debug('-----startDelay: ' + startDelay);
        System.debug('-----chunkDelay: ' + chunkDelay);
        System.debug('-----testObjects.size(): ' + testObjects.size());
         Integer cpuLimit = chunkDelay;

        while (cpuLimit>Limits.getCpuTime()){
            SObjectType test = Schema.getGlobalDescribe().get('Lead');
        }
        
        for(TestObject__c testObject : testObjects) {
            System.debug('-----testObject: ' + testObject);
            
            testObject.NumberField__c = this.val;
           
           
        }
        
        System.debug('-----testObjects.size(): ' + testObjects.size());
      
        update testObjects;
        
    }

    public void finish(Database.BatchableContext context) {
        System.debug('-----chunkNumber: ' + chunkNumber);
    }

    public Database.QueryLocator start(Database.BatchableContext context) {
        Database.QueryLocator queryLocator = Database.getQueryLocator([
                SELECT Id, Name, NumberField__c, TextField__c
                FROM TestObject__c
                WHERE Name LIKE 'TestBatchName%'
                ORDER BY Name
        ]);
        
        Integer cpuLimit = startDelay;

        System.debug('-----before delay');
        
        while (cpuLimit>Limits.getCpuTime()){
            SObjectType test = Schema.getGlobalDescribe().get('Lead');
        }
        
        System.debug('-----queryLocator: ' + queryLocator);
        
        return queryLocator;
    }
}