public class toporbottomAgent {
    String message=null;
    String userId=null;
    String fromDate=null;
    String toDate=null;
    String inputn;
    Integer intinputn;
    Boolean clicked = false;
    List<DisplayInfo> topAgents;
    List<DisplayInfo> displayInfoList=new List<DisplayInfo>(); 
       
    
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
    
    public PageReference runReport(){
           // PageReference page=new PageReference();
            Date fromDate = fromDateTask.From_Date__c;
             this.setfromDate(String.valueOf(fromDate));
            Date toDate= todateTask.To_Date__c;
            this.settodate(String.valueOf(toDate));
              inputn = agentno.No_of_Agents__c;
            this.setInputn(inputn );
            
            
            
            //displayInfoList=new List<DisplayInfo>();
            this.setUserId(getCurrentlyLoginCountryManagerSFId(UserInformation.getContextUserId()));
            //this.setUserId('a09400000025K1cAAE');
            this.setAllAgentsForCountryManagerSFId(this.getUserId());
            this.setClicked(true);
            //clicked =true;
            return null;
        }
        
        
        public void setClicked(Boolean cl){
            this.clicked=cl;
        }
        public Boolean getClicked(){
            return clicked;
        }
        
        public void setMessage(String message){
            this.message=message;
        }
        public String getMessage(){
            return message;
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
                System.debug('fromDate='+fromDate+' toDate='+toDate);
                
                if(fromDate!=null||toDate!=null){
                for(CountryManager_Agent__c cm : [select Agent__c from CountryManager_Agent__c where CountryManager__c = : userSfId])
                {
                    i++;
                    Double orc=ORCAgentWSReportClass.generatReportForParticularAgent(cm.Agent__c,userSfId,this.getFromDate(),this.getToDate());
                    Double basicCommission=BasicCommissionAgentWSReportClass.generatBasicCommissionForParticularAgent(cm.Agent__c,userSfId,this.getFromDate(),this.getToDate());
                    
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
                }
               // this.setMessage(String.valueOf(i));
             //   return agentSfIdList;
        }
        public List<Displayinfo> gettopnAgents(){ 
            topAgents = new List<DisplayInfo>();       
            DisplayInfo[] dispinfo = displayInfoList;
            List<DisplayInfo> topnAgents = new List<DisplayInfo>();
            //if(clicked==true){
            if(this.getClicked()==true){
                Integer m = dispinfo.size();
                for(Integer j=0;j<m-1;j++){
                    for(Integer k=j+1;k<m;k++){
                        if(dispinfo[j].orcAmount<dispinfo[k].orcAmount){
                            DisplayInfo temp = new DisplayInfo();
                            temp = dispinfo[j];
                            dispinfo[j] = dispinfo[k];
                            dispinfo[k] = temp;
                            temp = null;  
                        }          
                    }
                } 
                if(inputn!=null)
                    this.setIntinputn(inputn);  
                if(intinputn<=m){
                    for(Integer l=0;l<intinputn;l++){
                        topnAgents.add(dispinfo[l]); 
                    }
                    settopAgents(topnAgents);
                    dispinfo = null;
                    displayInfoList.clear();
                }else {
                    this.setMessage('There are only '+m+ 'Agents');  //system.debug('There are only '+m+ 'Agents');    
                    displayInfoList.clear();
                }
            }  
            //clicked = false;  
            this.setClicked(false);      
            return topnAgents;
        }
        public List<Displayinfo> getbottomnAgents(){        
            DisplayInfo[] dispinfo = displayInfoList;
            List<DisplayInfo> bottomnAgents = new List<DisplayInfo>();
            
            //if(clicked==true){
            if(this.getClicked()==true){
                Integer m = dispinfo.size();
                for(Integer j=0;j<m-1;j++){
               for(Integer k=j+1;k<m;k++){
                  if(dispinfo[j].orcAmount>dispinfo[k].orcAmount){
                   DisplayInfo temp = new DisplayInfo();
                    temp = dispinfo[j];
                    dispinfo[j] = dispinfo[k];
                    dispinfo[k] = temp;
                    temp = null;  
                    }          
               }
               } 
            this.setIntinputn(inputn);  
            if(intinputn<=m+1){
            for(Integer l=0;l<intinputn;l++){
                bottomnAgents.add(dispinfo[l]);                     
            }
            dispinfo = null;
            displayInfoList.clear();
            }else {
                 this.setMessage('Please enter valid number');  //system.assert(false);    
                 displayInfoList.clear();
                 }
    
            }  
            //clicked = false;
            this.setClicked(false);
            return bottomnAgents;
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
        
     public void setInputn(String s){
      this.inputn = s; 
    }
    public String getInputn(){
        return this.inputn;
    }
    public void setIntinputn(String s){
        if(inputn!=null)
            intinputn = Integer.valueOf(inputn);

    }
    public Integer getIntInputn(){
              return intinputn;
    }

     Date_Range__c fromDateTask = new Date_Range__c();
     Date_Range__c todateTask = new Date_Range__c();
     Date_Range__c agentno = new Date_Range__c();
    public Date_Range__c getFromDateTask() {
             return fromDateTask;
    }
    public Date_Range__c getToDateTask(){
        return todateTask;
    }
    public Date_Range__c getAgentno(){
        return agentno;
    }
    
    public void settopAgents(List<Displayinfo> s){
        topAgents = s;
     
    }
    public List<Displayinfo> gettopAgents(){
        return topAgents ;
    }      

}