trigger TestTrigger on test1__c (before insert, before update) {
  	 for(test1__c t:trigger.new){
  	 	if(t.job_app_name__c=='newjob'){
  	 	 t.job_app_name__c = 'namechanged';
  	 	}
  	   
  	 }


}