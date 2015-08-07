public class MailTest {
private static final String EMAIL_ADDRESS = 'anil_pasha@persistent.co.in';
public  static void sendWithRecordAttachment()
{
//Job_Application__c jobApplication = new Job_Application__c();
// Create the email to the candidate and attach schedule
Messaging.SingleEmailMessage mail =
new Messaging.SingleEmailMessage();
mail.setToAddresses( new String[]{'anil_pasha@persistent.co.in'});
mail.setTemplateId('00X50000000tLlW');
mail.setwhatId('0015000000My7qj');
 mail.setTargetObjectId ('0035000000WU8lE');
 
Messaging.sendEmail(new Messaging.SingleEmailMessage[]{ mail });

}

public PageReference sendmail() {
    sendWithRecordAttachment();
            return null;
    }

}