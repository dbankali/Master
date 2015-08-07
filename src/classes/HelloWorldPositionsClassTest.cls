public class HelloWorldPositionsClassTest {

	static testMethod void helloWorldTest(){
 
		List<Position__c> positions = new List<Position__c>();
		for (Position__c p : [Select Id, Hello__c, Pay_Grade__c from Position__c limit 1]){
			p.Pay_Grade__c = 'ENG-300';
			positions.add(p);
		}
		
		try{
			System.debug('Attempting to update positions');
			update positions;
			System.debug('Update complete');
			System.assertEquals(positions[0].Hello__c, 'World');
			System.debug('Hello World!');
		} catch (System.DmlException e){
			System.debug('We caught a DML exception: ' + e.getDmlMessage(0));	
		}
		
	}
	
}