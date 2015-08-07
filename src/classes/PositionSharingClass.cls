public class PositionSharingClass {
	
	// Method that receives position records and shares them to the respective Hiring Manager
	public static void addBulkPS(Position__c[] positions){
		System.debug('creating bulk Position__Share records');
		Position__Share[] posShares = new Position__Share[0];
		
		for (Position__c p:positions){
			Position__Share ps = new Position__Share();
			
			ps.ParentId = p.Id;
			ps.UserOrGroupId = p.Hiring_Manager__c;
			ps.AccessLevel = 'Edit';
			System.debug('this is ps: ' + ps);
			posShares.add(ps);
		}
		
		try {
			System.debug('performing bulk Position__Share insert');
			insert posShares;
		} catch (System.DmlException e) {
			System.debug('error bulk inserting position shares');
			for (Integer k = 0; k < e.getNumDml(); k++) {
				// Process exception here
				System.debug(e.getDmlMessage(k));
			}
		}
	
	}
	
	// Method that receives a Position Map and for each Position shares the related JobApps and 
	//   Candidate records with the Hiring Managerof the respective Position
	public static void addBulkJACS(Map<Id,Position__c> newPosMap){
		System.debug('creating bulk JobApp__Share & Candidate__Share records');
				
		// create a list for job app shares
		Job_Application__Share[] jas = new Job_Application__Share[0];
		
		// create a list for candidate shares
		Candidate__Share[] cs = new Candidate__Share[0];
		
		// get all the Job Apps related to any of the Positions
		for (Job_Application__c[] jobApps:[Select Id,Position__c,Candidate__c from Job_Application__c 
										where Position__c IN :newPosMap.keySet()]){
											
			// before we go through the current batch of Job Application records, let's clear out the Job App Share list and Candidate Share list first
			jas.clear();
			cs.clear();
			
			for (Job_Application__c jobApp:jobApps){
				System.debug('jobApp.id = ' + jobApp.Id);
				
				// need to get a copy of the current position record so we can get to the Hiring Manager Id
				Position__c p = newPosMap.get(jobApp.Position__c);
				
				// create the job app sharing record
				Job_Application__Share j = new Job_Application__Share();
				j.ParentId = jobApp.id;
				j.UserOrGroupId = p.Hiring_Manager__c;
				j.AccessLevel = 'Edit';
				// add the job app share onto the jas list
				jas.add(j);
			
				// now do the same thing for Candidate
				//***TODO: Mirror what was done for Job Application here***
				//for (Candidate__c cand:cs){
				//System.debug('candidate.id = ' + cs.Id);
				
				// need to get a copy of the current position record so we can get to the Hiring Manager Id
				//Position__c p = newPosMap.get(cand.Position__c);
				
				// create the job app sharing record
				Candidate__Share c = new Candidate__Share();
				c.ParentId = jobApp.Candidate__c;
			    c.UserOrGroupId = p.Hiring_Manager__c;
				c.AccessLevel = 'Edit';
				// add the job app share onto the jas list
				cs.add(c);
			
			}	
		    
			// now insert the current batch of records			
			try {
				System.debug('performing JobApp__Share insert');
				insert jas;
			} catch (System.DmlException e) {
				System.debug('error inserting job app shares');
				for (Integer i = 0; i < e.getNumDml(); i++) {
					// Process exception here
					System.debug(e.getDmlMessage(i));
				}
			}
			try {
				System.debug('performing Candidate__Share insert');
				insert cs;
			} catch (System.DmlException e) {
				System.debug('error inserting candidate shares');
				for (Integer j = 0; j < e.getNumDml(); j++) {
					// Process exception here
					System.debug(e.getDmlMessage(j));
				}
			}
		}
	}

}