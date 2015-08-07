global class BasicCommissionAgentWSReportClass{
public static double totalRevenue=0.0;
WebService static Double generatBasicCommissionForParticularAgent(String agentSfId, String cmSfId,String ipfromdate, String iptodate){
    System.debug('====================================================');
    System.debug('FROM DATE $$$$$$$$$$$$$$$$$$$$4  '+ipfromdate);
    System.debug('TO DATE $$$$$$$$$$$$$$$$$$$$4  '+iptodate);
    System.debug('agentSfId='+agentSfId);
    System.debug('cmSfId='+cmSfId);
    Date chkfromdate= Date.valueOf(ipfromdate);
    Date chktodate=Date.valueOf(iptodate);
    Date fromDate,toDate;
    Double total_basic_comm = 0;
    Double total_revenue = 0;
    String basicCommStr='Basic Commission';
    Integer i=0;
    Integer j=0;
    Double temp=0;
    for(Rule__c rule : [select ORCPercent__c,Year__c from Rule__c where CountryManager__c = : cmSfId and RuleName__c = : basicCommStr] )
    {// Mostly this for loop will execute only once
        total_revenue = 0;  
        Integer year=(rule.Year__c).intValue();
//      fromDate=Date.newInstance(year,1,1);
//      toDate=Date.newInstance(year,12,31);
        fromDate=chkfromdate;
        toDate=chktodate;
//      if(fromdate>=chkfromdate)
//      {
//          if(todate<=chktodate)
//          {
                for(Flown_Data__c flownData : [select TicketFare__c from Flown_Data__c where Agent__c = : agentSfId and CountryManager__c =: cmSfId and Flying_Mon_Yr__c < : todate and Flying_Mon_Yr__c >: fromdate])      
                {
                    System.debug(' INSIDE for(Flown_Data__c flownData : [select TicketFare__c from Flown_Data__c where Agent__c = : agentSfId and CountryManager__c =: cmSfId and Flying_Mon_Yr__c < : todate and Flying_Mon_Yr__c >: fromdate])');
                    i++;
                    total_revenue = total_revenue + flownData.TicketFare__c;
                    System.debug('I='+i+' total_revenue='+total_revenue);

                }
                System.debug('Total_revenue:'+total_revenue);
                totalRevenue=total_revenue;
                total_basic_comm = (total_revenue * rule.ORCPercent__c)/100;
//          }
//      }
    }
    System.debug('====================================================');

return total_basic_comm;
//return i;
}

}