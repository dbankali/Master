Public Class LeadAccountController{
    List<LeadAccount> leadAccountList = new List<LeadAccount>();
    Boolean isAllSelected = false;
    
    public List<LeadAccount> getLeadAccountList()
    {
        leadAccountList.clear();
            for(contactList__c c: [select List_Name__c from ContactList__c])
            {
                LeadAccount leadAccount = new LeadAccount();
                leadAccount.setIsSelected(isAllSelected);
                leadAccountList.add(leadAccount);
            }
        return leadAccountList;
    }
    public Boolean getIsAllSelected(){return isAllSelected;}
    public void setIsAllSelected(Boolean isAllSelected){
     System.debug('-------------inside setter---------'+ isAllSelected);
    this.isAllSelected = isAllSelected;}
    public PageReference selectAll()
    {
      System.debug('=========Inside select All=========');
        //.....How to write code?
          System.debug('isAllSelected'+ getIsAllSelected());
       for(leadaccount a: leadAccountList) {         
         a.setIsSelected(isAllSelected);
         System.debug('getter--- '+ a.getIsSelected());
        }
        return null;
    }
   /* public void selectAll() {
        for(leadaccount a: leadAccountList) {         
         a.setIsSelected(true);
        }
    }*/
    
}