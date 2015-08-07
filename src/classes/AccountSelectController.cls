public class AccountSelectController {

    public PageReference genSAcct() {
        SAcct = getSAcct();
        return null;
    }
   
    public class cAcct{
        public Account theacct {get; set;}
        public Boolean selected{get; set;}
       
        public cAcct(Account a,Boolean s){
            theacct = a;
            selected = s;
        }
    }
    
    //A collection of the class/wrapper objects cAcct
    
    //The fist list includes all Accounts
    public List<cAcct> MyAcct;// {get; set;}
    
    //The second list only inclues Accouts selected
    public List<cAcct> SAcct {get; set;}

   //This method uses a SOQL query to return a list of all Accounts
    public List<cAcct> getMyAcct(){
          if(MyAcct == null){
              MyAcct = new List<cAcct>();
              for(Account acct : [Select Name FROM Account]){
                    /* As each opportunity is processed I create a new cOpportunity object and add it to MyList */
                    cAcct myadd = new cAcct(acct,FALSE);
                    MyAcct.add(myadd);
              }
          }
        return MyAcct;
    }
    
    //This method uses looks at the full account list and adds only those with "selected" = true
    public List<cAcct> getSAcct(){
      if (MyAcct != null) {  
          if (SAcct == null) {
              SAcct = new List<cAcct>();
              for(cAcct cacct : MyAcct){
                  /* As each Accout is processed, check if the selected value is true. */
                  if (cacct.selected == TRUE) {
                      SAcct.add(cacct);
                  }
              }
              for(cAcct cacct : MyAcct){
                cacct.selected = TRUE;
              }
          }
          return SAcct;
      } else {
          SAcct = null;
          return SAcct;
      }
    }
}