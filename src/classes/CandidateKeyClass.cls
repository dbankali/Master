public class CandidateKeyClass {
       // This method acts as a uniqueness checker for the Candidate object based on the Email__c field
	public static void hasCandidateDuplicates(Candidate__c[] candidates){
		
        //define a map for unique Candidates:
		// ***TODO: Declare a candidate map, and remember that ID is not what we are using to test uniqueness here***		
        Map<String, Candidate__c> candidateMap = new Map<String,Candidate__c>();
        for(Candidate__c candidate:candidates) {
		String lastName = candidate.Last_Name__c.toLowerCase();
        	String email = candidate.Email__c.toLowerCase();
        	String uKey = lastName + email;
        	        	
            // ignore candidates with a null email
            if (email != null){
            	//look for dupes within the batch
				if(candidateMap.containsKey(uKey)) candidate.addError('Duplicate LastName + Email found in batch'); 
				else candidateMap.put(uKey, candidate);      
            }
		}
		
		//now hit the DB looking for dupes
		for(Candidate__c[] candidatesCheck:[select Id,unique_key__c from Candidate__c where unique_key__c IN :candidateMap.keySet()]) {
			for(Candidate__c candidate:candidatesCheck) {
				//if there's a dupe, add the error.
				if(candidateMap.containsKey(candidate.unique_key__c)) candidateMap.get(candidate.unique_key__c).addError('Duplicate LastName + Email found in salesforce(id: ' + candidate.id + ')');
			}
		}
	} // end hasCandidateDuplicates
}