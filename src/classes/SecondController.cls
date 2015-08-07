public class SecondController {
Account account;
String date1;
    public PageReference save() {
    update account;
    pageReference pref= Page.mysecondpage;
    pref.setRedirect(true);
    pref.getParameters().put('id',account.id);
        return pref;
    }


    public String getName(){
      return 'SecondController';
    }

    public Account getAccount() {
    if(account==null){
        account = [select id,name from Account where id= :ApexPages.currentPage().getParameters().get('id')];
             }   
             return account;

    }
    public String getDate1(){
    return this.date1;
    }
    public void setDate1(String date1){
    this.date1= date1;
    }

}