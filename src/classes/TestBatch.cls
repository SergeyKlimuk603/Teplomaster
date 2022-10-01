public class TestBatch implements Database.Batchable<sObject>, Database.AllowsCallouts, Queueable {
   private String query;
    private String newStageName;
    private List<Opportunity> oppList;
    
    public TestBatch(String oppName, String newStageName) {
        this.query = 'SELECT Id, StageName FROM Opportunity WHERE Name = \'' + oppName + '\'';
        this.newStageName = newStageName;
    }
    
    public TestBatch(List<Opportunity> oppList, String newStageName) {
        this.oppList = oppList;
        this.newStageName = newStageName;
    }

//   public Database.QueryLocator start(Database.BatchableContext BC){
//      return Database.getQueryLocator(query);
//   }
//   
   public List<Opportunity> start(Database.BatchableContext BC){
      return oppList;
   }

   public void execute(Database.BatchableContext BC, List<Opportunity> scope){
       System.debug('----- scope: ' + scope);
       //scope[0].StageName = newStageName;
       //update scope;
       
       System.enqueueJob(new TestBatch(scope, newStageName));
   }

   public void finish(Database.BatchableContext BC){
   }
    
    public void execute(QueueableContext context) {
       oppList[0].StageName = newStageName;
       update oppList;       
    }
}