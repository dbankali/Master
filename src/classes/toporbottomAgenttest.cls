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
private class toporbottomAgenttest {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
       List<toporbottomAgent.DisplayInfo> displayInfoList=new List<toporbottomAgent.DisplayInfo>(); 
        //Call the runReport method of toporbottomAgent
        
        //System.debug('In myUnitTest....');
        toporbottomAgent toporbottomAgentObject=new toporbottomAgent();
        toporbottomAgent toporbottomAgentObject2=new toporbottomAgent();
        
        toporbottomAgent.DisplayInfo displayInfoObj=new toporbottomAgent.DisplayInfo();
        
        //Date fromDate=(toporbottomAgentObject.getFromDateTask()).From_Date__c;
        //Date fromDate=new Date(2006,2,2);
               
        //Date fromDate=Date.valueOf('2006-2-2');
        //toporbottomAgentObject.setfromDate(String.valueOf(fromDate));
        
        //Date toDate=Date.valueOf('2008-2-2');
        //toporbottomAgentObject.settodate(String.valueOf(toDate));
        
        Date fromDate=Date.valueOf('2006-01-01');
        Date_Range__c rangeFrom=toporbottomAgentObject.getFromDateTask();
        rangeFrom.From_Date__c=fromDate;
        
        Date toDate=Date.valueOf('2008-12-31');
        Date_Range__c rangeTo=toporbottomAgentObject.getToDateTask();
        rangeTo.To_Date__c=toDate;
        
        
        toporbottomAgentObject.setInputn('3');
        toporbottomAgentObject.setIntinputn('3');
        
		//toporbottomAgentObject.setUserId('a0940000001vkwlAAA');
			//toporbottomAgentObject.setUserId('a0940000001vkwlAAA');
		toporbottomAgentObject.runReport();	
        //toporbottomAgentObject.setAllAgentsForCountryManagerSFId('a09400000025K1cAAE');
        
        toporbottomAgentObject.gettopnAgents();
        
        toporbottomAgentObject.getFromDate();
        toporbottomAgentObject.getMessage();
        toporbottomAgentObject.getToDate();
        toporbottomAgentObject.getDisplayInfoList();
        toporbottomAgentObject.getFromDateTask();
        toporbottomAgentObject.getToDateTask();
        toporbottomAgentObject.getAgentno();
        toporbottomAgentObject.getInputn();
        toporbottomAgentObject.getIntInputn();
        
        
        //System.assertEquals(fromDate,null);        
        toporbottomAgentObject.setClicked(true);
        
        displayInfoObj.getBasicCommissionAmount();
        displayInfoObj.getTotalCommissionAmount();
        displayInfoObj.getAgentId();
        displayInfoObj.getAgentName();
        displayInfoObj.getOrcAmount();
        
        toporbottomAgentObject.getbottomnAgents();
        
        
        ////For else part
        
        toporbottomAgentObject2.setInputn('3');
        toporbottomAgentObject2.setIntinputn('3');
        
		//toporbottomAgentObject.setUserId('a0940000001vkwlAAA');
			//toporbottomAgentObject.setUserId('a0940000001vkwlAAA');
		toporbottomAgentObject2.runReport();	
        //toporbottomAgentObject.setAllAgentsForCountryManagerSFId('a09400000025K1cAAE');
        
        toporbottomAgentObject2.gettopnAgents();
        
        toporbottomAgentObject2.getFromDate();
        toporbottomAgentObject2.getMessage();
        toporbottomAgentObject2.getToDate();
        toporbottomAgentObject2.getDisplayInfoList();
        toporbottomAgentObject2.getFromDateTask();
        toporbottomAgentObject2.getToDateTask();
        toporbottomAgentObject2.getAgentno();
        toporbottomAgentObject2.getInputn();
        toporbottomAgentObject2.getIntInputn();
        
        
        //System.assertEquals(fromDate,null);        
        toporbottomAgentObject2.setClicked(true);
        
        displayInfoObj.getBasicCommissionAmount();
        displayInfoObj.getTotalCommissionAmount();
        displayInfoObj.getAgentId();
        displayInfoObj.getAgentName();
        displayInfoObj.getOrcAmount();
        
        toporbottomAgentObject2.getbottomnAgents();
        
        
    }
}