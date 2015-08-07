public class SendEMail
{
private static final String EMAIL_ADDRESS = 'anil_pasha@persistent.co.in';
public static void sendSimple()
{
Messaging.SingleEmailMessage mail = new
Messaging.SingleEmailMessage();
mail.setToAddresses(new String[] { EMAIL_ADDRESS });
mail.setSubject('Message from Apex!');
mail.setPlainTextBody('This is the message body');
Messaging.sendEmail(new Messaging.SingleEmailMessage[]{ mail });
}
}