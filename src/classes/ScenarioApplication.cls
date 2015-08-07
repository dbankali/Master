public class ScenarioApplication
{
    String selectedYear;
    String selectedmetric='Agent Revenue';
    String selectedcriteria='Grows By';
    String selectedMonth='0';
    Double SelectedMonthRevenue=0.0;
    Double SelectedMonthCommission=0.0;
    Double GrowthCommission=0.0;
    Double percent=0.0;
    Double coffiecient=0.0;
    double slope=0.0;    
    List<String> fromInputDates=new List<String>();
    List<String> toInputDates=new List<String>();
    String selectedoption='';
    List<Double> commission=new List<Double>();
    List<Double> revenue=new List<Double>();
    List<List<Double>> commissionLists=new List<List<Double>>();
    List<List<Double>> revenueLists=new List<List<Double>>();
    double revenueMax=0.0;
    double commissionMax=0.0;
    public double getRevenueMax()
    {
    return revenueMax;
    }
    public double getCommissionMax()
    {
    return commissionMax;
    }
    
    public String getSelectedmetric() {
        System.debug('sel met '+selectedmetric);
                return selectedmetric;
        }
  
    public void setSelectedmetric (String selectedmetric ) {
            this.selectedmetric = selectedmetric ;
    }
    
    
    public String getSelectedoption(){
    
       return this.selectedoption;
    }
    
    public void setSelectedoption(String selectedoption){
    
      this.selectedoption = selectedoption;
    }
    public String getSelectedcriteria() {
        return selectedcriteria;
    }

    public void setSelectedcriteria (String selectedcriteria ) {
            this.selectedcriteria = selectedcriteria ;
    }
    public Double getPercent(){
           return percent;
    }
    
    public void setPercent(Double percent){
      this.percent = percent;
    }
    public String getSelectedYear(){
           return selectedYear;
    }
    
    public void setSelectedYear(String selectedYear){
      this.selectedYear= selectedYear;
    }
    public String getSelectedMonth(){
           return selectedMonth;
    }
    
    public void setSelectedMonth(String selectedMonth){
      this.selectedMonth= selectedMonth;
    }
        public List<SelectOption> getOptions() {
                List<SelectOption> options = new List<SelectOption>();
                options.add(new SelectOption('Please Select Agent','Please Select Agent'));
                 for(Agent__c agent:[select Id,AgentName__c from Agent__c order by AgentName__c]){
                 System.debug('agent ids  '+agent.Id);
                 options.add(new SelectOption(agent.Id,agent.AgentName__c));         
                 }
             return options;
          }
          public List<SelectOption> getCriteria() {
                List<SelectOption> criteria = new List<SelectOption>();
                criteria.add(new SelectOption('Grows By','Revenue Grows By'));
                criteria.add(new SelectOption('Declines By','Revenue  Declines By'));
                //options.add(new SelectOption('MEXICO','Mexico'));
                return criteria;
          }
          public List<SelectOption> getYears() {
                List<SelectOption> years= new List<SelectOption>();
                Date obj = Date.today();
                Integer year=obj.year();
                //selectedYear=String.valueof(year-4);
                for(Integer i=4;i>0;i--)
                {
                Integer yr=year-i;
                String strYear=String.valueof(yr);
                years.add(new SelectOption(strYear,strYear));
                }
                return years;
          }
          
          public List<SelectOption> getMonths() {
                List<SelectOption> criteria = new List<SelectOption>();
                criteria.add(new SelectOption('0','January'));
                criteria.add(new SelectOption('1','February'));
                criteria.add(new SelectOption('2','March'));
                criteria.add(new SelectOption('3','April'));
                criteria.add(new SelectOption('4','May'));
                criteria.add(new SelectOption('5','June'));
                criteria.add(new SelectOption('6','July'));
                criteria.add(new SelectOption('7','August'));
                criteria.add(new SelectOption('8','September'));
                criteria.add(new SelectOption('9','October'));
                criteria.add(new SelectOption('10','November'));
                criteria.add(new SelectOption('11','December'));
                
                //options.add(new SelectOption('MEXICO','Mexico'));
                return criteria;
          }
          public void getDateInputs()
          {
         // '2005-02-01'
         
              Date obj = Date.today();
              Integer year=obj.year();
              year=year-4;
              List<Integer> numberOfDaysInMonth=new List<Integer>();
              fromInputDates=new List<String>();
              toInputDates=new List<String>();
              for(Integer i=1;i<=12;i++)
              {
                  Integer numberDays =date.daysInMonth(year, i);
                  numberOfDaysInMonth.add(numberDays);
              }
             // String ='';
              String to='';
              String fromString ='';
              for(Integer i=1;i<=12;i++)
              {
                  
                  fromString+=selectedYear;
                  fromString+='-';
                  
                  fromString+=String.valueOf(i);
                  
                  fromString+='-';
                  fromString+='01';
                  fromInputDates.add(fromString);
                  fromString='';
                  
                  to+=selectedYear;
                  to+='-';
                  
                  to+=String.valueOf(i);
                  
                  to+='-';
                  to+=String.valueOf(numberOfDaysInMonth.get(i-1));
                  toInputDates.add(to);
                  to='';
                  
              }
              for(Integer i=0;i<fromInputDates.size();i++)
              {
                  System.debug('baser'+fromInputDates.get(i)+'jdjkasd    '+toInputDates.get(i));
              }
              
          }
          

    public PageReference save() {
    getDateInputs();
    commissionDataForBestFeetGraph=new List<Double>();
    revenue=new List<Double>();
    commission=new List<Double>();
    String cmId=getCurrentlyLoginCountryManagerSFId(UserInformation.getContextUserId());
    commissionLists=new List<List<Double>>();
    revenueLists=new List<List<Double>>();
    
        String agentID=selectedoption;
        setAllAgentsForCountryManagerSFId(cmId,agentID);
        getSelectedMonthRevenueAndCommission(cmId,agentID);
   
    for(Integer i=0;i<commissionLists.get(0).size();i++)
    {
        Double temp=0;
        for(Integer j=0;j<commissionLists.size();j++)
        {
            
            temp+=commissionLists.get(j).get(i);
            
        }
        commission.add(temp);
    }
    for(Integer i=0;i<revenueLists.get(0).size();i++)
    {
        Double temp=0;
        for(Integer j=0;j<revenueLists.size();j++)
        {
            
                temp+=revenueLists.get(j).get(i);
               
        }
        revenue.add(temp);
    }
    
    operationsOnData();
    
    revenueMax=revenue.get(0);
    for(Integer i=0;i<revenue.size();i++)
    {
        if(revenueMax<revenue.get(i))
        {
            revenueMax=revenue.get(i);
        }
    }
    commissionMax=commission.get(0);
    for(Integer i=0;i<commission.size();i++)
    {
        if(commissionMax<commission.get(i))
        {
            commissionMax=commission.get(i);
        }
    }
        Double percentage=percent;
        if(selectedcriteria.equals('Declines By'))
         {
         percentage=-percentage;
         }
        double rate=percentage/100;
        
        double revenueGrowth=SelectedMonthRevenue+(rate*SelectedMonthRevenue);
        revenue.add(revenueGrowth);
    
        GrowthCommission=revenueGrowth*slope+coffiecient;
        GrowthCommission=Math.round(GrowthCommission);
        commissionDataForBestFeetGraph.add(GrowthCommission);
       
        return null;
    }
    
    
    public String getCurrentlyLoginCountryManagerSFId(String userId) {
                String userSfId=null;
                for(CountryManger__c cm : [select ID from CountryManger__c where Country_Manager_Name__c = : userId])
                {
                    userSfId=cm.id;
                }
                return userSfId;
        }
        
        
        
        
        public void setAllAgentsForCountryManagerSFId(String userSfId,String agentId) {
            
            
           
                    List<Double> tempCommissionList=new List<Double>();
                    List<Double> tempRevenueList=new List<Double>();
                    for(Integer j=0;j<fromInputDates.size();j++)
                    {
                            Double orc=ORCAgentWSReportClass.generatReportForParticularAgent(agentId,userSfId,fromInputDates.get(j),toInputDates.get(j));
                            Double basicCommission=BasicCommissionAgentWSReportClass.generatBasicCommissionForParticularAgent(agentId,userSfId,fromInputDates.get(j),toInputDates.get(j));
                            Double TotalRevenue=BasicCommissionAgentWSReportClass.totalRevenue;
                            Double totalCommission=orc+basicCommission;
                            tempCommissionList.add(totalCommission);
                            tempRevenueList.add(TotalRevenue);
                    }
                    commissionLists.add(tempCommissionList);
                    revenueLists.add(tempRevenueList);
            
          }
          public void getSelectedMonthRevenueAndCommission(String userSfId,String agentId)
          {
              Integer dateIndex=Integer.valueof(selectedMonth);
              Double orc=ORCAgentWSReportClass.generatReportForParticularAgent(agentId,userSfId,fromInputDates.get(dateIndex),toInputDates.get(dateIndex));
              Double basicCommission=BasicCommissionAgentWSReportClass.generatBasicCommissionForParticularAgent(agentId,userSfId,fromInputDates.get(dateIndex),toInputDates.get(dateIndex));
              SelectedMonthRevenue=BasicCommissionAgentWSReportClass.totalRevenue;
              SelectedMonthCommission=orc+basicCommission;
              
          }
        
        public List<Double> commissionDataForBestFeetGraph=new List<Double>();
        public List<Double> getCommissionDataForBestFeetGraph()
        {
            return commissionDataForBestFeetGraph;
        }
        public List<Double> getRevenueDataForGraph()
        {
            return revenue;
        }
        public List<Double> getCommissionDataForGraph()
        {
            return commission;
        }
        
        public void operationsOnData()
        {
            commissionDataForBestFeetGraph=new List<Double>();
            Matrix inverseMatrix=new Matrix(revenue.size(),2);
            MatrixMultiplication multiplicationMatrix=new MatrixMultiplication(commission.size(),1);
            Integer count=0;
            for(Integer i=0;i<revenue.size();i++)
            {
                for(Integer j=0;j<2;j++)
                {
                    if(findModulous(count)==0)
                    {
                        inverseMatrix.setValue(i, j, revenue.get(i));
                        
                    }
                    else
                    {
                        inverseMatrix.setValue(i, j,1);
                    }
                    count++;
                }
            }
            for(Integer i=0;i<commission.size();i++)
            {
                for(Integer j=0;j<1;j++)
                {
                    multiplicationMatrix.setValue(i, j, commission.get(i));
                   
                }
            }
            Matrix resultInverse=inverseMatrix.inverse();
            
            List<List<Double>> revenueArray = new List<List<Double>>();
            for( Integer row = 0; row < 2; row++ ) {
              List<Double> columns=new List<Double>();
            for(Integer col=0;col<revenue.size();col++)
            {
                  
                 columns.add(0.0);
                 
           
            }
            revenueArray.add(columns);
                
            }
    
            
            for(Integer i=0;i<2;i++)
            {
                for(Integer j=0;j<revenue.size();j++)
                {
                    revenueArray.get(i).set(j,resultInverse.getValue(i, j));
                }
                
            }
            List<List<Double>> result=multiplicationMatrix.matrixMultiplication(revenueArray);
            coffiecient=result.get(1).get(0);
            slope=result.get(0).get(0);
            for(Integer i=0;i<revenue.size();i++)
            {
            
            double bestFeetData=(slope*revenue.get(i))+coffiecient;
            commissionDataForBestFeetGraph.add(bestFeetData);
            
            }
            System.debug('cofficient@@@@@@@@@@@@@@@@@@@@@@@@@@    '+coffiecient);
            System.debug('slope@@@@@@@@@@@@@@@@@@@@@@@@@@    '+slope);
        }
        public Integer findModulous(Integer i)
        {
            Integer temp1=i/2;
            temp1=temp1*2;
            return (i-temp1);
        }
        public Double getGrowthCommission() {
            return GrowthCommission;
        }
    
    
        public Double getSelectedMonthCommission() {
            return SelectedMonthCommission;
        }
               
        
}