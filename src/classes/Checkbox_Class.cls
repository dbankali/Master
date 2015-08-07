public class Checkbox_Class 
{
  
   /*
   * This source code was written by SrinivasaRao Pendala. 
   * I have made every effort and taken great care in making sure that the source
   * code and other content included on my wiki is technically accurate.
   * As with any code, ensure to test this code in a development environment 
   * before attempting to run it in production.
   */

    List<accountwrapper> accountList = new List<accountwrapper>();
    List<Account> selectedAccounts = new List<Account>();
        
    public List<accountwrapper> getAccounts()
    {
        for(Account a : [select Id, Name, AccountNumber, Phone from Account limit 5])
        accountList.add(new accountwrapper(a));
        return accountList;
    }
    
    public PageReference getSelected()
    {
        selectedAccounts.clear();
        for(accountwrapper accwrapper : accountList)
        if(accwrapper.selected == true)
        selectedAccounts.add(accwrapper.acc);
        return null;
    }
    
    public List<Account> GetSelectedAccounts()
    {
        if(selectedAccounts.size()>0)
        return selectedAccounts;
        else
        return null;
    }    
    
    public class accountwrapper
    {
        public Account acc{get; set;}
        public Boolean selected {get; set;}
        public accountwrapper(Account a)
        {
            acc = a;
            selected = false;
        }
    }
}