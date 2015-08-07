trigger PositionDeleteTrigger on Position__c (before delete) {
	
	// Show an error whenever someone attempts to delete a Position with a Job Application associated to it.
	
	for (Job_Application__c ja : [select position__c from Job_Application__c where position__c in :Trigger.oldMap.keySet()]) {

		Trigger.oldMap.get(ja.position__c).addError('Cannot delete position with a job application');
	}

}