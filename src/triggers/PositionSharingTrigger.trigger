trigger PositionSharingTrigger on Position__c (after insert, after update) {
	//***TODO: Declare a list of Positions named 'positions' from the trigger***
	Position__c[]  positions = Trigger.new;
	// first, we must create Position__Share records
	//***TODO: Invoke the method in the class to share position records***	
	PositionSharingClass.addBulkPS(positions);
	// second, we need to create Job_Application__Share and Candidate__Share records
	//    that are associated to the Position records that were updated (not needed for Insert)
	if (Trigger.isUpdate){
		Map<Id, Position__c> newPosMap = Trigger.newMap; 
		//***TODO: Invoke the method in the class to share job apps and candidates***	
			PositionSharingClass.addBulkJACS(newPosMap);
	}

}