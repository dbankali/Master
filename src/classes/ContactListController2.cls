public class ContactListController2{
   Integer noofContacts=0;
     String listId = null;
       Boolean panelDisplay = false;
       
        List<ContactList__c>  contactLists = new List<ContactList__c>();
     List<ContactList__c> selectedCList = new List<ContactList__c>();
   List<contact> contacts = new List<Contact>(); 
   //Wrapper Class
     public class ContactList{
         public ContactList__c theCList{get;set;}
         public Boolean selected{get;set;}
         public Integer count{get;set;}
         
         public ContactList(ContactList__c cl, Boolean s,Integer ct){
               theCList = cl;
               selected = s;        
               count = ct;
         }     
     }
     public List<ContactList> cList ;
     
    public List<ContactList> sCList {get;set;}
    // displays all in the list
    public List<ContactList> getCList(){
         if(cList==null){
            cList = new List<ContactList>();
            for(ContactList__c cl:[select Id, List_Name__c,Comments__c, Access__c from ContactList__c order by List_Name__c]){
            Integer i = 0;
                  i = [select count() from Contact where ContactList__c=:cl.Id];
                  ContactList clst = new ContactList(cl,false,i);
                  cList.add(clst);            
             }        
         }
         return cList;
    }
    
    //displays selected data
    public List<ContactList> getSCList(){
       if(cList!=null){
          if(sCList==null){
              sCList = new List<ContactList>();
             for(ContactList c:cList){
                if(c.selected==true){
                   sClist.add(c);
                }             
             }          
          }    return sCList;   
       }else {
          sCList = null;
          return sCList;
        }
    
    } 
    
    //to fetch the selected contact lists
   /* public List<ContactList__c> getSCList(){
      return  this.sCList;    
    }
      
    public void setSCList(List<ContactList__c> sCList){
           this.sCList = sCList;                       
    }*/

//to display all the contact lists 
  /* public List<ContactList__c> getContactLists(){
   Integer no_of_contacts=0;
    //  List<ContactList__c>  contactLists = new List<ContactList__c>();
      List<ContactList__c>  contactLists1 = new List<ContactList__c>();
        contactLists = [select Id,List_Name__c,Access__c,Comments__c from ContactList__c order by List_Name__c];
        Integer count=0;
        for(ContactList__c clist:contactLists ){
          no_of_contacts = [select count() from Contact where ContactList__c =:clist.Id];
           system.debug('no of contacts in the list '+no_of_contacts);
           this.setNoofContacts(no_of_contacts);
           ContactList__c cl = contactLists.get(count);
           count = count+1;
           System.debug('---------------------------------------------->'+this.getNoofContacts());
           //Decimal d = this.getNoofContacts();
           cl.no_of_contacts__c = this.getNoofContacts();
           contactLists1.add(cl);
           cl=null;
           //noofContacts=0;      
           no_of_contacts = 0;  
        }
       
      return contactLists1;
   } 
   public Integer getNoofContacts(){
      return this.noofContacts;
   }
   public void setNoofContacts(Integer noofContacts){
     this.noofContacts = noofContacts;   
   }*/
   public void setContacts(List<Contact> contacts){
       this.contacts = contacts;
   }
   public List<Contact> getContacts(){
     return this.contacts;
   }
   public void setPanelDisplay(Boolean panelDisplay){
      this.panelDisplay = panelDisplay;
   }
   
   public Boolean getPanelDisplay(){
     return this.panelDisplay;
   } 
   
   public void setselectedCList(List<ContactList__c> selectedCList ){
        this.selectedCList  = selectedCList ;   
   }
   public List<ContactList__c> getselectedCList (){
     return this.selectedCList ;   
   }
   String listName = null;
   public void setListName(String listName){
      this.listName = listName;
   }
   public String getListName(){
     return this.listName;
   }
  //fetches contacts related to the list. Called from command link action    
   public List<Contact> getContactsByListId(){
             system.debug('----------------> In gcbl');
           this.setPanelDisplay(true);
           PageReference pageRef = ApexPages.currentPage();
             Map<String,String> contactMap = pageRef.getparameters();
              String listId = contactMap.get('Id');
              this.setListName(contactMap.get('List_Name__c'));
             List<Contact> listofContacts = new List<Contact>();
           listofContacts  = [select Id,Name__c,Address__c,Country__c,ContactList__c from Contact where ContactList__c =:listId order by Name__c];   
           System.debug('>>>>>>>>>>>>>>>>'+listofContacts)  ;
           return listofContacts;
   }
   //Command link action to fetch the contacts related to the list 
   public PageReference contactsList(){
   System.debug('Session -------------'+UserInfo.getSessionId());
   System.debug('link in action');
      List<Contact> listofContacts = getContactsByListId();
      this.setContacts(listofContacts);
      System.debug('<<<<<<<<<<<<<<<<<<<<   end   >>>>>>>>>>>>>>>>>>>>>> ');
       return null;
   }    
   
   // redirects to results page.
   public PageReference download(){
   System.debug('----------------inside Download');
        sCList = getSCList();
           if(sCList!=null){
              PageReference xls= Page.selectedContactLists;
              xls.setredirect(false);
              return xls;
           }else {
             Apexpages.message mymsg = new Apexpages.message(ApexPages.Severity.INFO,'You must select at least one period','User selected '+sCList.size()+' periods');
            Apexpages.addmessage(mymsg);
            return null;         
         }
        /* if(selectedrecs>0){
            System.debug('----------------  Not Null');
            PageReference xls= Page.selectedContactLists;
            xls.setredirect(false);
            return xls;         
         }else {
             Apexpages.message mymsg = new Apexpages.message(ApexPages.Severity.INFO,'You must select at least one period','User selected '+selectedRecs+' periods');
            Apexpages.addmessage(mymsg);
            return null;         
         }*/       
       // return null;
    }

}