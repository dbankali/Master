/**
 * Email services are automated processes that use Apex classes
 * to process the contents, headers, and attachments of inbound
 * email.
 */
global class ContactEmailHandler implements Messaging.InboundEmailHandler {

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        Contact myCont = new Contact();
        myCont.firstname='Anil';
        myCont.lastName = 'Pasha';
        myCont.Email = email.fromAddress;
        myCont.Description = email.subject;  
        myCont.OwnerId = UserInfo.getUserId();      
		insert myCont;
        return result;
    }
}