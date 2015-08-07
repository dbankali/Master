public class MyControllerExtension {
     private final Account account;
    public MyControllerExtension(ApexPages.StandardController controller) {
    this.account = (Account)controller.getRecord();

    }
    public String getGreeting(){
      return 'Hello' + account.name ;
      }

}