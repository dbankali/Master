trigger CandidateKeyTrriger on Candidate__c (before insert, before update) {
	// get the batch of new candidates and pass them to the compositeKey package for checking
	private Candidate__c[] newCandidates = Trigger.new;   // ***TODO: Complete this line***
	// ***TODO: Call the correct method***(newCandidates);
    CandidateKeyClass.hasCandidateDuplicates(newCandidates);
}