public class HelloWorldPositionClass {
//TODO: Write the method declaration with these arguments:*** (Position__c[] positions){
                
public static void getPosition(Position__c[] positions){
                for (Position__c p:positions){
                        if (p.Hello__c != 'World') {
                                // Insert a reference to the Hello field*** = 'World';
                                p.Hello__c='World';
                        }
                }
        }
}



/*public class HelloWorldPositionClass {
    ***TODO: Write the method declaration with these arguments:*** (Position__c[] positions){
		public static void addHelloWorld(Position__c[] positions){
		for (Position__c p:positions){
			if (p.Hello__c != 'World') {
				p.Hello__c = 'World';
			}
		}
	}
}*/