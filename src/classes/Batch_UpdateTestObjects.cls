/**
 * Created by user on 9/30/22.
 */

public with sharing class Batch_UpdateTestObjects implements Database.Batchable<sObject>, Schedulable, Database.Stateful{

    private final Integer START_NEW_BATCH_PERIOD = 5;

    private String query = 'SELECT Id, Name, TextField__c, CheckboxField__c, NumberField__c ' +
            'FROM TestObject__c ' +
            'WHERE CheckboxField__c = TRUE';

    private Integer numOfSuccessfulRecords = 0;
    private Integer startDelay;
    private Integer chunkDelay;


    //Constructors
    public Batch_UpdateTestObjects() {}

    public Batch_UpdateTestObjects(String query) {
        this.query = query;
    }

    public Batch_UpdateTestObjects(Integer startDelay, Integer chunkDelay) {
        setDelayTimes(startDelay, chunkDelay);
    }

    public Batch_UpdateTestObjects(String query, Integer startDelay, Integer chunkDelay) {
        this(query);
        setDelayTimes(startDelay, chunkDelay);
    }

    //Schedulable
    public void execute(SchedulableContext schedulableContext) {
        Database.executeBatch(new Batch_UpdateTestObjects(query));
    }

    //Batchable
    public Database.QueryLocator start(Database.BatchableContext batchableContext) {
        Database.QueryLocator queryLocator = Database.getQueryLocator(query);

        delay(startDelay);

        return queryLocator;
    }

    public void execute(Database.BatchableContext batchableContext, List<TestObject__c> testObjects) {
        System.debug('-----testObjects.size(): ' + testObjects.size());
        for(TestObject__c testObject : testObjects) {
            System.debug('-----testObject: ' + testObject);
        }
        List<TestObject__c> testObjectsForUpdate = updateTestObjects(testObjects);

        delay(chunkDelay);



        List<Database.SaveResult> results = Database.update(testObjectsForUpdate, false);
        List<Id> successUpdateRecords = new List<Id>();
        List<Id> failedUpdateRecords = new List<Id>();
        for (Database.SaveResult result : results) {
            System.debug('-----result: ' + result);
            Id recordId = result.getId();
            result.isSuccess() ? successUpdateRecords.add(recordId) : failedUpdateRecords.add(recordId);
        }
        //System.debug('-----results: ' + results);
        numOfSuccessfulRecords += results.size();
    }

    public void finish(Database.BatchableContext batchableContext) {
        System.debug('-----numOfSuccessfulRecords: ' + numOfSuccessfulRecords);

        if (Database.query(query + ' LIMIT 1').isEmpty()) {
            return;
        }

//        System.scheduleBatch(
//                new Batch_UpdateTestObjects(query),
//                Batch_UpdateTestObjects.class.getName(),
//                START_NEW_BATCH_PERIOD
//        );
    }

    //Others
    private List<TestObject__c> updateTestObjects(List<TestObject__c> testObjects) {
        //List<TestObject__c> testObjectsForUpdate = new List<TestObject__c>();

        for (TestObject__c testObject : testObjects) {
            testObject.CheckboxField__c = false;
            testObject.TextField__c = 'Checkbox was changed';
            if(testObject.Name == 'Batch_UpdateTestObjects_30') {
                testObject.TextField__c = '0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000';
            }
        }

        return testObjects;
    }

    private void delay(Integer delayTime) {
        while (delayTime > Limits.getCpuTime()){
            SObjectType test = Schema.getGlobalDescribe().get('Lead');
        }
    }

    private void setDelayTimes(Integer startDelay, Integer chunkDelay) {
        this.startDelay = startDelay * 1000;
        this.chunkDelay = chunkDelay * 1000;
    }

}