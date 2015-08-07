global class EmailTestWebServiceClass{

     webService static Boolean updateEmailTest(String[] emailTo,String[]emailCc,String emailSubject,String emailBody){
        EmailTest__c eObj = new EmailTest__c();
        System.debug('In updateEmailTest...emailTo='+emailTo.size());
        System.debug('EmailTo[0]:'+emailTo[0]+' EmailTo[1]:'+emailTo[1]);
        //eObj.emailTo__c = emailTo;
        eObj.emailTo__c = 'yashavant_bhalekar@persistent.co.in';
       //eObj.emailCc__c = emailCc;
        eObj.emailCc__c = 'yashavant.bhalekar@gmail.com';
        eObj.emailFrom__c = 'yashavant_bhalekar@persistent.co.in';
        eObj.emailSubject__c=emailSubject;
        eObj.emailBody__c=emailBody;
        eObj.emailNotification__c=true;
                
        try{
            EmailTestWebServiceClass.sendWithRecordAttachment(emailTo,emailCc,emailSubject,emailBody);
            insert eObj;
            System.debug('returning from updateEmailTest...true');
            return true;
        } catch (System.DmlException e) {
            System.debug('error bulk inserting new job application');
            for (Integer k = 0; k < e.getNumDml(); k++) {
                // Process exception here
                System.debug(e.getDmlMessage(k));
            }
            System.debug('returning from updateEmailTest...false');
            return false;
        }
    }
    public static void sendWithRecordAttachment(String[] emailTo,String[] emailCc,String emailSubject,String emailBody){
        System.debug('In sendWithRecordAttachment');
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        //mail.setToAddresses( new String[]{emailTo});
        mail.setToAddresses( emailTo);
        mail.setCcAddresses(emailCc);
        mail.setSubject(emailSubject);
        mail.setPlainTextBody(emailBody);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{ mail });
        System.debug('Returning from sendWithRecordAttachment');
    }
   /* public PageReference sendmail() {
          sendWithRecordAttachment();
            return null;
    }
    */
}