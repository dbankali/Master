trigger HelloWorldPositionTrigger on Position__c (before insert, before update) {

Position__c[] poss = Trigger.new;
HelloWorldPositionClass.getPosition(poss);

}


/*trigger HelloWorldPositionTrigger on Position__c (before insert, before update) {
    Position__c[] positions = Trigger.new;
	    HelloWorldPositionClass.addHelloWorld(positions); 
}*/