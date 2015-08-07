/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class ORC_For_All_Agenttest {

    static testMethod void myUnitTest() {
        ORC_For_All_Agent orcAgent=new ORC_For_All_Agent();
        
        Date fromDate=Date.valueOf('2006-01-01');
        Date_Range__c rangeFrom=orcAgent.getFromDateTask();
        rangeFrom.From_Date__c=fromDate;
        
        Date toDate=Date.valueOf('2008-12-31');
        Date_Range__c rangeTo=orcAgent.getToDateTask();
        rangeTo.To_Date__c=toDate;
        //orcAgent.getToDateTask().To_Date__c=toDate;
        
        
        
        
        
        
        
        
        
        
        orcAgent.setFromDate('2006-01-01');
       // System.assertEquals('2006-01-01',orcAgent.getFromDate());
        
        
        orcAgent.setToDate('2008-12-31');
        //System.assertEquals('2008-12-31',orcAgent.getToDate());
        System.assertEquals(null,orcAgent.generateReport());
        List<ORC_For_All_Agent.DisplayInfo> displayInfoList=orcAgent.getDisplayInfoList();
        for(Integer i=0;i<displayInfoList.size();i++)
        {
            displayInfoList.get(i).getAgentName();
            
            displayInfoList.get(i).getAgentId();
            displayInfoList.get(i).getOrcAmount();
            displayInfoList.get(i).getBasicCommissionAmount();
            displayInfoList.get(i).getTotalCommissionAmount();
        }
        
        Date_Range__c fromDateTask=orcAgent.getFromDateTask();
        Date_Range__c todateTask=orcAgent.getToDateTask();
        orcAgent.setMessage('I am in setMessage');
        orcAgent.getMessage();
        //Test Case for UserInformation Apex class
        UserInformation user=new UserInformation();
        UserInformation.getContextUserName();
        UserInformation.getContextUserFirstName();
        UserInformation.getContextProfileId();
    }
}