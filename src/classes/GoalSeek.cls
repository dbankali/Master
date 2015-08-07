public class GoalSeek {
    List<RevenueData> revenueDataList=null;
    List<DisplayData> displayList=null;
    String message;
    
    public String getMessage(){
        System.debug('In getMessage :'+this.message);
        return this.message;
    }
    public void setMessage(String message){
        System.debug('In setMessage :'+message);
        this.message = message;    
    }
    
    String renderFlag = 'false';
    public String getRenderFlag() {
        return this.renderFlag; 
    }
    public void setRenderFlag(String renderFlag){
        this.renderFlag = renderFlag;
    } 
    
    public List<DisplayData> getDisplayList() {
        return this.displayList;
    }
    
    public void setDisplayList(List<DisplayData> displayList){
        this.displayList=displayList;
    }

   public class RevenueData{
        String agentId;
        String agentName;
        Double numberOfTicketSold;
        Double priceOfTicket;
        Double revenue;
        
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
        
        public void setNumberOfTicketSold(Double numberOfTicketSold){
            this.numberOfTicketSold=numberOfTicketSold;
        }
        public Double getNumberOfTicketSold(){
            return this.numberOfTicketSold;
        }
        
        public void setPriceOfTicket(Double priceOfTicket){
            this.priceOfTicket=priceOfTicket;
        }
        public Double getPriceOfTicket(){
            return this.priceOfTicket;
        }
        public void setRevenue(Double revenue){
            this.revenue=revenue;
        }
        public Double getRevenue(){
            return this.revenue;
        }
    }
    
    public class DisplayData{
        String agentId;
        Integer numberOfTicketToSold;
        String agentName;           
        
        /*public void setAgentId(String agentId){
            this.agentId=agentId;
        }
        public String getAgentId(){
            return this.agentId;
        }*/
        
        public void setAgentName(String agentName){
            this.agentName=agentName;
        }
        public String getAgentName(){
            return this.agentName;
        }
        
        public void setNumberOfTicketToSold(Integer numberOfTicketToSold){
            this.numberOfTicketToSold=numberOfTicketToSold;
        }
        public Integer getNumberOfTicketToSold(){
            return this.numberOfTicketToSold;
        }
    }
    
    Double totalRevenueForAllAgent;
    
    Integer totalAvailableAgentCount;
    
    public void setTotalAvailableAgentCount(Integer totalAvailableAgentCount){
        this.totalAvailableAgentCount=totalAvailableAgentCount;
    }
    public Integer getTotalAvailableAgentCount(){
        return this.totalAvailableAgentCount;
    }
    
    public void setTotalRevenueForAllAgent(Double totalRevenueForAllAgent){
        this.totalRevenueForAllAgent=totalRevenueForAllAgent;
    }
    public Double getTotalRevenueForAllAgent(){
        return this.totalRevenueForAllAgent;
    }
    
    /*public String getProjectedrevenue() {
        return null;
    }*/
    private String userId=null;
     public void setUserId(String userId){
            System.debug('In SET User Id ='+userId); 
            this.userId=userId;
        }
        public String getUserId(){
            System.debug('In GET User Id ='+userId); 
            return this.userId;
        }
    public String getCurrentlyLoginCountryManagerSFId(String userId) {
            String userSfId=null;
            System.debug('In getCurrentlyLoginCountryManagerSFId :'+userId);
            for(CountryManger__c cm : [select ID from CountryManger__c where Country_Manager_Name__c = : userId])
            {
                System.debug('In for loop :'+cm.id);
                userSfId=cm.id;
            }
            return userSfId;
    }
    public PageReference estimate(){
        revenueDataList = null;
        //setRenderFlag(true);
        
        Boolean validateFlag=true;
        
        validateFlag=isValid();
        if(validateFlag){
        
            this.setUserId(getCurrentlyLoginCountryManagerSFId(UserInformation.getContextUserId()));
            
            this.reteriveData();
            //this.displayRevenueData();
            List<DisplayData> displayDataList=this.calculateProjectedData();
            if(displayDataList.size() == 0){
                this.setMessage('NO records are present.');
                this.setRenderFlag('false'); 
                this.setDisplayErrorFlag('false');
                this.setDisplayInfoFlag('true');
            }else{
                //reterive display list and set to following method.
                this.setDisplayList(displayDataList);
                //this.setMessage('The Goal Seek data is displayed in below tabular format.');
                this.setRenderFlag('true'); 
            }
        }else{
            this.setDisplayErrorFlag('true');
            this.setDisplayInfoFlag('false');
            this.setRenderFlag('false'); 
        } 
        
        return null;
    }
    public List<DisplayData> calculateProjectedData(){
        displayList = new List<DisplayData>();
        
        Double targetRevenue=Double.valueOf(getTargetrevenue());
        
        if(revenueDataList != null){
            for(Integer i=0;i<getTotalAvailableAgentCount();i++){
                DisplayData dataObject= new DisplayData();
                RevenueData revenueDataObject=revenueDataList.get(i);
                System.debug('Agent Id ='+revenueDataObject.agentId+' Revenue ='+revenueDataObject.revenue);
                Double percentageOfRevenue=(revenueDataObject.getRevenue() * 100)/(this.getTotalRevenueForAllAgent());
                
                Integer tiketsToSold=((targetRevenue*percentageOfRevenue)/100).intValue();
                
                dataObject.setAgentName(revenueDataObject.getAgentName());
                dataObject.setNumberOfTicketToSold(tiketsToSold);
                
                displayList.add(dataObject);
            }
            System.debug('Total Revenue for all agent :'+this.getTotalRevenueForAllAgent());
        }
        
        return displayList;
    }
   /* public void displayRevenueData(){
        if(revenueDataList != null){
            for(Integer i=0;i<getTotalAvailableAgentCount();i++){
                RevenueData revenueDataObject=revenueDataList.get(i);
                System.debug('Agent Id ='+revenueDataObject.agentId+' Revenue ='+revenueDataObject.revenue);
            }
            System.debug('Total Revenue for all agent :'+this.getTotalRevenueForAllAgent());
        }
    }*/
    
    public void reteriveData(){
        //Set the revenueDataList in this function
        
        revenueDataList = new List<RevenueData>();
       
        Double targetRevenue=Double.valueOf(getTargetrevenue());
        //Integer year=(Double.valueOf(getYear())).intValue();
        //String quarter=getQuarter();
        String classType=getClasstype();
        
        Double totalRevenueForAllAgent=0;
        Integer agentCount=0;
        
        Date tmpDate=Date.today();
        //Date tmpDate=Date.newInstance(2006,10,1);// This is used for testing purpose only. If no data is present for that period.

        Integer numberOfDaysInMonth=Date.daysInMonth(tmpDate.year(),tmpDate.month());
        
        Date fromDate=Date.newInstance(tmpDate.year()-1,tmpDate.month(),1);
        Date toDate=Date.newInstance(tmpDate.year(),tmpDate.month(),numberOfDaysInMonth);
        
        System.debug('tmpDate:'+tmpDate+'Month :'+tmpDate.month()+' Year :'+tmpDate.year()+' numberOfDaysInMonth :'+numberOfDaysInMonth);
        
        System.debug('From Date :'+fromDate+' To Date :'+toDate);
                
        System.debug('Target revenue :'+targetRevenue);
        System.debug('Class Type     :'+classType);
       // System.debug('Quarter        :'+quarter);
        //System.debug('Year           :'+year);
        //String cmSfId=this.getUserId();
        String userSfId=UserInformation.getContextUserId();
        System.debug('Currently login user sfid ='+userSfId);
        for(Agent__c agent : [select id,AgentName__c from Agent__c where UserLookup__c = : userSfId ] )//we have to add the condition for currently login CM.
        {
           RevenueData revenueDataObject=new RevenueData();
           //System.debug('Agent Id :'+agent.id+' Name ='+agent.AgentName__c);
           Boolean flag=false;
           //revenueDataObject.agentId=String.valueOf(goalSeekData.AgentId_LP__c);
           revenueDataObject.setAgentId(agent.id);//Same as above stmt   String.valueOf(goalSeekData.AgentId_LP__c);
           revenueDataObject.setAgentName(agent.AgentName__c);
           System.debug('Agent name :'+agent.AgentName__c);
           Double revenueOfAgent=0;
           Double priceOfTicket=0;
           Double numberOfTicketSold=0;
           Integer count=1;
           //for(GoalSeek__c goalSeekData : [select AgentId_LP__c,NumberOfTicketSold__c,PriceOfTicket__c,TotalRevenue__c from GoalSeek__c where Transaction_Date__c >= : fromDate and Transaction_Date__c <= : toDate and ClassType__c = :classType and AgentId_LP__c = : agent.id ]){
           for(Flown_Data__c fdData : [select Agent__c,TicketId__c,TicketFare__c from Flown_Data__c where Flying_Mon_Yr__c >= : fromDate and Flying_Mon_Yr__c <= : toDate and Travel_Class__c = :classType and Agent__c = : agent.id ]){
               count++;
               System.debug('Agent Id :'+agent.id+' Name ='+agent.AgentName__c+' AgentId LP :'+fdData.Agent__c);
               revenueOfAgent= revenueOfAgent + fdData.TicketFare__c;
               priceOfTicket=20;
               //priceOfTicket=priceOfTicket+goalSeekData.PriceOfTicket__c;
               //numberOfTicketSold=numberOfTicketSold+goalSeekData.NumberOfTicketSold__c;             
               numberOfTicketSold=count;
               totalRevenueForAllAgent=totalRevenueForAllAgent+fdData.TicketFare__c;
               flag=true;
               //System.debug('Agent Id ='+goalSeekData.AgentId_LP__c+' No Ticket Sold ='+goalSeekData.NumberOfTicketSold__c+' Revenue ='+goalSeekData.TotalRevenue__c);
           }
           if(flag){
               count--;
              /* revenueDataObject.numberOfTicketSold=numberOfTicketSold;
               revenueDataObject.priceOfTicket=priceOfTicket/count;
               revenueDataObject.revenue=revenueOfAgent;*/
               
               revenueDataObject.setNumberOfTicketSold(numberOfTicketSold);
               revenueDataObject.setPriceOfTicket(priceOfTicket/count);
               revenueDataObject.setRevenue(revenueOfAgent);
               
               revenueDataList.add(revenueDataObject);
               
               agentCount++;
           }
        }
        this.setTotalRevenueForAllAgent(totalRevenueForAllAgent);
        this.setTotalAvailableAgentCount(agentCount);
                 
    }
    

        String targetrevenue;
        String classtype;
        String quarter;
        String year;
        
        
        public String getTargetrevenue(){
          return targetrevenue;
        }
        public void setTargetrevenue(String targetrevenue){
           this.targetrevenue = targetrevenue;
        }
        
        public String getClasstype(){
          return classtype;
        }
        public void setClasstype(String classtype){
           this.classtype= classtype;
        }
        
        public String getQuarter(){
          return quarter;
        }
        public void setQuarter(String quarter){
           this.quarter= quarter;
        }

        public List<SelectOption> getQuarters() {
                List<SelectOption> quarters= new List<SelectOption>();
                quarters.add(new SelectOption('JAN-MAR','Q1(JAN-MAR)'));
                quarters.add(new SelectOption('APR-JUN','Q2(APR-JUN)'));
                quarters.add(new SelectOption('JUL-SEP','Q3(JUL-SEP)'));
                quarters.add(new SelectOption('OCT-DEC','Q4(OCT-DEC)'));
                return quarters;
        }
        
        public List<SelectOption> getPeriods() {
                List<SelectOption> periods= new List<SelectOption>();
                periods.add(new SelectOption('1','Next Month'));
                periods.add(new SelectOption('2','Next Quarter'));
                periods.add(new SelectOption('3','Next Half Year'));
                periods.add(new SelectOption('4','Next Year'));
                return periods;
        }        
        
        public List<Selectoption> getclasstypes() {
           List<SelectOption> types = new List<SelectOption>();
           types.add(new SelectOption('Economy','Economy'));
           types.add(new SelectOption('Business','Business'));
           return types;
        }
        public String getYear(){
          return year;
        }
        public void setYear(String year){
           this.year = year;
        }

        public List<Selectoption> getYears(){
            String[] yearlist =new String[]{'2008','2009','2010','2011'};
            List<SelectOption> years = new List<SelectOption>();
            String j = '2007';
            for(Integer i=0; i<yearlist.size() ;i++){
                 years.add(new SelectOption(yearlist[i],yearlist[i]));
            }
            return years;
        }
        String displayErrorFlag='false';
        String displayInfoFlag='false';
        
        public String getDisplayErrorFlag(){
            System.debug('In getDisplayErrorFlag() :'+this.displayErrorFlag);
            return this.displayErrorFlag;
        }
        public void setDisplayErrorFlag(String displayErrorFlag){
            System.debug('In setDisplayErrorFlag() :'+displayErrorFlag);
            this.displayErrorFlag=displayErrorFlag;
        }
        
        public String getDisplayInfoFlag(){
            System.debug('In getDisplayInfoFlag() :'+this.displayInfoFlag);
            return this.displayInfoFlag;
        }
        public void setDisplayInfoFlag(String displayInfoFlag){
            System.debug('In setDisplayInfoFlag() :'+displayInfoFlag);
            this.displayInfoFlag=displayInfoFlag;
        }
                
        public Boolean isValid(){
            Boolean flag=true;
            
            System.debug('targetrevenue='+targetrevenue+'.');
            if(targetrevenue.equals('')){
                System.debug('Revenue Target is required...');
                flag=false;
                this.setMessage('Revenue Target is required...');
            }else{
                try{
                    Double targetRevenue=Double.valueOf(getTargetrevenue());
                    if(targetRevenue<0){
                        System.debug('Revenue Target should be positive number...');
                        flag=false;
                        this.setMessage('Revenue Target should be positive number...');
                    }
                }catch(TypeException e){
                    System.debug('Revenue Target should be numeric...');
                    flag=false;
                    this.setMessage('Revenue Target should be numeric...');
                }
            }
            return flag;
        }
                 
}