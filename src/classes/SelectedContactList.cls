global class SelectedContactList{
  public static List<ContactList__c> selectedList = new List<ContactList__c>();
  public static Integer listSize =0; 
  webservice static Integer selected(String[] cl){
        System.debug('==========inside S  C  L');
      //List<ContactList__c> sList = new List<ContactList__c>();
      //ContactListController clc = new ContactListController();
      //clc.download();
      Integer ls = cl.size();
        System.debug('=========='+ls);
       setListSize(ls);
      //setSelectedList(cl);
      System.debug('===============getListSize()'+getListSize());
      return getListSize();
  
  }
  public static void setListSize(Integer ls){
      listSize = ls;
  }
  public static Integer getListSize(){
      return listSize; 
  }
  public static void setSelectedList(List<ContactList__c> selectedContactList ){
      selectedList = selectedContactList ;  
  }
  public static List<ContactList__c> getSelectedList(){
    return selectedList;  
  } 
  

}