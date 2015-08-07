public class ORC_For_All_Agent {
    String message=null;
    String userId=null;
    String fromDate=null;
    String toDate=null;
    List<DisplayInfo> displayInfoList=new List<DisplayInfo>();
    
   // Task fromDateTask = new Task();
    //Task toDateTask = new Task();    
    
    Date_Range__c fromDateTask= new Date_Range__c();
    Date_Range__c todateTask= new Date_Range__c();
    public Date_Range__c getFromDateTask() {
             return fromDateTask;
    }
    public Date_Range__c getToDateTask(){
    return todateTask;
    }
      
   // public Task getFromDateTask() { return fromDateTask; }

   // public Task getToDateTask() { return toDateTask; }    
    
    public class DisplayInfo{
        public String agentId;
        public String agentName;
        public Double orcAmount;
        public Double basicCommissionAmount;
        public Double totalCommissionAmount;
        
        public void setAgentId(String agentId){
            this.agentId=agentId;
        }
        public String getAgentId(){
            return this.agentId;
        }
        public void setAgentName(String agentName){
            this.agentName=agentName;
        }
        public String getAgentName(){
            return this.agentName;
        }
        public void setOrcAmount(Double orcAmount){
            this.orcAmount=orcAmount;
        }
        public Double getOrcAmount(){
            return this.orcAmount;
        }
        public void setBasicCommissionAmount(Double basicCommissionAmount){
            this.basicCommissionAmount=basicCommissionAmount;
        }
        public Double getBasicCommissionAmount(){
            return this.basicCommissionAmount;
        }
        public void setTotalCommissionAmount(Double totalCommissionAmount){
            this.totalCommissionAmount=totalCommissionAmount;
        }
        public Double getTotalCommissionAmount(){
            return this.totalCommissionAmount;
        }
    }
    
    public PageReference generateReport(){
            PageReference page=new PageReference('http://www.google.com');
            
            Date fromDate = fromDateTask.From_Date__c;
            //Date fromDate = fromDateTask.activitydate;
            //this.setfromDate(String.valueOf(fromDate));
            this.setFromDate(String.valueOf(fromDate));

            Date toDate= todateTask.To_Date__c;
            //Date toDate = toDateTask.activitydate;
            //this.settodate(String.valueOf(toDate));
            this.setToDate(String.valueOf(toDate));
            
            displayInfoList.clear();
            //

            this.setUserId(getCurrentlyLoginCountryManagerSFId(UserInformation.getContextUserId()));
            //this.setUserId('a09400000025K1cAAE');
            this.setAllAgentsForCountryManagerSFId(this.getUserId());
            for(Integer i=0;i<displayInfoList.size();i++)
    {
        DisplayInfo info=displayInfoList.get(i);
        //System.debug('info.getAgentName    '+ info.getAgentName);
        System.debug('info.getBasicCommissionAmount    '+ displayInfoList.get(i));
       // System.debug('info.getOrcAmount    '+ info.getOrcAmount);
    }
            return null;
        }
        
        public void setMessage(String message){
            this.message=message;
        }
        public String getMessage(){
            return this.message;
        }
        public void setUserId(String userId){
            this.userId=userId;
        }
        public String getUserId(){
            return this.userId;
        }
        
        public void setFromDate(String fromDate){
            this.fromDate=fromDate;
        }
        public String getFromDate(){
            return this.fromDate;
        }
        
        public void setToDate(String toDate){
            this.toDate=toDate;
        }
        public String getToDate(){
            return this.toDate;
        }
        
        public List<DisplayInfo> getDisplayInfoList(){
            return this.displayInfoList;
        }
        
      //  public void setDisplayInfoList(List<DisplayInfo> list){
      //      this.displayInfoList=list;
      //  }
        public String getCurrentlyLoginCountryManagerSFId(String userId) {
                String userSfId=null;
                for(CountryManger__c cm : [select ID from CountryManger__c where Country_Manager_Name__c = : userId])
                {
                    userSfId=cm.id;
                }
                return userSfId;
        }
        public void setAllAgentsForCountryManagerSFId(String userSfId) {
                String agentSfId=null;
                Integer i=0;
                System.debug('userSfId ='+userSfId);
                for(CountryManager_Agent__c cm : [select Agent__c from CountryManager_Agent__c where CountryManager__c = : userSfId])
                {
                    System.debug('Inside for(CountryManager_Agent__c cm : [select Agent__c from CountryManager_Agent__c where CountryManager__c = : userSfId])');
                    i++;
                    Double orc=ORCAgentWSReportClass.generatReportForParticularAgent(cm.Agent__c,userSfId,this.getFromDate(),this.getToDate());
                    Double basicCommission=BasicCommissionAgentWSReportClass.generatBasicCommissionForParticularAgent(cm.Agent__c,userSfId,this.getFromDate(),this.getToDate());
                    
                    System.debug(' I ='+i+' ORC ='+orc+' B commission ='+basicCommission);
                    DisplayInfo obj=new DisplayInfo();
                    obj.setAgentId(cm.Agent__c);
                    obj.setAgentName(getAgentNameForAgentSFId(cm.Agent__c));
                    obj.setOrcAmount(Math.round(orc));
                    obj.setBasicCommissionAmount(basicCommission);
                    obj.setTotalCommissionAmount(basicCommission+Math.round(orc));
                    if((Math.round(orc)!= 0.0)&&(basicCommission != 0.0)){
                        displayInfoList.add(obj);
                    }
                }
               // this.setMessage(String.valueOf(i));
             //   return agentSfIdList;
        }
        public String getAgentNameForAgentSFId(String agetnSfId) {
                String agentName=null;
                Integer i=0;
                for(Agent__c agent : [select AgentName__c from Agent__c where ID = : agetnSfId])
                {
                    i++;
                    agentName=agent.AgentName__c;
                }
               return agentName;
        }

}