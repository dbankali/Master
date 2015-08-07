global class ORCAgentWSReportClass{
WebService static Double generatReportForParticularAgent(String agentSfId, String cmSfId,String ipfromdate, String iptodate){

Date chkfromdate= Date.valueOf(ipfromdate);
Date chktodate=Date.valueOf(iptodate);
Date fromDate,toDate;
Double total_orc = 0;
Double total_revenue = 0;
Integer i=0;
Integer j=0;
Double temp=0;
System.debug(' agentSfId ='+agentSfId+' cmSfId ='+cmSfId+' chkfromdate='+chkfromdate+' chktodate='+chktodate);
for(AgentRule__c agentRule : [select LP_Rule_Id__c from AgentRule__c where LP_Agent_Id__c = : agentSfId])
{
System.debug('I am in outer loop of ORCAgentWSReportClass');
    i++;
    for(Rule__c rule : [select ORCPercent__c,Revenue_Max__c,Revenue_Min__c,Quarter__c,Year__c from Rule__c where ID = : agentRule.LP_Rule_Id__c] )
    {
        System.debug('I am in Inner loop of ORCAgentWSReportClass');
//      j++;
        String quarter=rule.Quarter__c;Integer year=(rule.Year__c).intValue();
        if(quarter == 'JAN-MAR')
        {
            fromDate=Date.newInstance(year,1,1);toDate=Date.newInstance(year,3,31);
        }else if(quarter == 'APR-JUN')
        {
            fromDate=Date.newInstance(year,4,1);toDate=Date.newInstance(year,6,30);
        }else if(quarter == 'JUL-SEP')
        {
            fromDate=Date.newInstance(year,7,1);toDate=Date.newInstance(year,9,30);
        }else if(quarter == 'OCT-DEC')
        {
            fromDate=Date.newInstance(year,10,1);toDate=Date.newInstance(year,12,31);
        }
        total_revenue = 0;
        System.debug('fromdate='+fromdate+' todate='+todate);
        if(fromdate>=chkfromdate)
        {
            if(todate<=chktodate)
            {
                j=j+2;
                for(Flown_Data__c flownData : [select TicketFare__c from Flown_Data__c where Agent__c = : agentSfId and CountryManager__c =: cmSfId and Flying_Mon_Yr__c < : toDate and Flying_Mon_Yr__c > : fromDate])
                {
                    total_revenue = total_revenue + flownData.TicketFare__c;
                    System.debug('Inside @@@@@@@@@@@@ tot revenue ='+total_revenue);
                }
                temp=total_revenue;
                System.debug('############### total_revenue='+total_revenue+' rule.Revenue_Max__c='+rule.Revenue_Max__c+' rule.Revenue_Min__c='+rule.Revenue_Min__c);
                if(total_revenue < rule.Revenue_Max__c)
                {
                    if( total_revenue > rule.Revenue_Min__c)
                    {
                        total_orc = total_orc + (total_revenue * rule.ORCPercent__c)/100;
                    }
                }
            }else{
                j=j+6;
            }
        }else{

            j= j+3;
        }
    }
}
System.debug('Returning total_orc='+total_orc);
return total_orc;
//return temp;

}

}