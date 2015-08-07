public class MileStone {

    public MileStone(ApexPages.StandardController controller) {

    }

private MileStone__c milestone = new MileStone__c();
 public String Id;
 Double nextmilestone;
public void setID(String Id){
   this.Id = Id;
}
public MileStone__c getMilestone(){
  return this.milestone;
}

public String getId(){
  return this.Id;
}
public PageReference nextMileStone(){
    
   String nextId =null; //[select Id from MileStone__c where MileStoneNumber__c = MileStoneNumber__c+1 and Opportunity=Opportunity__c];
   this.setId(nextId);
   return null;
}
}