/*public class MyController1 withsharing{
   list<account> totallist = new List<account>();
   list<account> pageList = new List<account>();
    public String getName() {
        return 'Mycontroller1';
    }
    public PageReference accounts(){
    List<account> temp = List<account>();
      temp= getAccount();
      integer div = 5;
      integer listsize= temp.size();
    
    }
    
    public List<Account> getAccount(){
     totallist= [select id,Name from Account];
     return totallist;
     }
      
     
}     
*/
 public class MyController1 {
        
        static List<String> selected = new List<String>();
       public String getName() {
        return 'Mycontroller1';
    }
        public Account[] getAccount(){
     return [select id,Name from Account];
     } 
      public List<String> getselectedAcc(){
                      return HelloWorld2.getselected();
         }    
         
              
    
}