public class OpportunityTriggerHandler extends TriggerHandler {
    
    protected override void beforeUpdate() {
		System.debug('----- beforeUpdate()');        
    }
    protected override void afterUpdate() {
        System.debug('----- afterUpdate()');
        List<Opportunity> oldList = Trigger.old;
        Map<Id, Opportunity> newMap = (Map<Id, Opportunity>) Trigger.newMap;
        for(Opportunity opp : oldList) {
            for (Integer i = 0; i < 2; i++) {
                notFutureMethod();
            }
        }
    }
    
    @future (callout=true)
    public static void futureMethod() {
        System.debug('----- futureMethod()');
        methodBody();
    }
    
    public static void notFutureMethod() {
        System.debug('----- notFutureMethod()');
        if (System.isBatch()) {
            methodBody();
            return;
        }
        futureMethod();
    }
    
    public static void methodBody() {
        System.debug('----- methodBody()');
        someCallout();
        someCallout();
        someCallout();
        someCallout();
        someCallout();
        someCallout();
        someCallout();
        someCallout();
        someCallout();
        someCallout();
    }
    
    static Integer calloutsNumber = 0;
    public static void someCallout() {
        calloutsNumber++;
        System.debug('----------------------------------------------------------------- someCallout() ' + calloutsNumber);
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
		request.setMethod('GET');
		HttpResponse response = http.send(request);
		// If the request is successful, parse the JSON response.
		if(response.getStatusCode() == 200) {
		    // Deserialize the JSON string into collections of primitive data types.
		    Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
		    // Cast the values in the 'animals' key as a list
		    List<Object> animals = (List<Object>) results.get('animals');
		    System.debug('Received the following animals:');
		    for(Object animal: animals) {
		        System.debug('-----animal: ' + animal);
		    }
}
    }
}