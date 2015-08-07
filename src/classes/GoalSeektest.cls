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
private class GoalSeektest {
    static testMethod void myUnitTest() {
        GoalSeek goalSeek=new GoalSeek();
        goalSeek.setMessage('I am in GoalSeek SetMessage');
        goalSeek.getMessage();
        goalSeek.setRenderFlag('true');
        goalSeek.getRenderFlag();
        goalSeek.setTargetrevenue('1000');
        goalSeek.getTargetrevenue();
        goalSeek.setClasstype('Economy');
        goalSeek.getClasstype();
        goalSeek.setQuarter('1');
        goalSeek.getQuarter();
        goalSeek.estimate();
        
        List<GoalSeek.DisplayData> displayList=GoalSeek.getDisplayList();
        for(Integer i=0;i<displayList.size();i++)
        {
            displayList.get(i).getAgentName();
            displayList.get(i).getNumberOfTicketToSold();
        }
        List<SelectOption> quarters=goalSeek.getQuarters();
        List<SelectOption> periods=goalSeek.getPeriods();
        List<SelectOption> types =goalSeek.getclasstypes();
        goalSeek.setYear('2008');
        goalSeek.getYear();
        List<SelectOption> years=goalSeek.getYears();
        goalSeek.setDisplayErrorFlag('I am in GoalSeek setDisplayErrorFlag');
        goalSeek.getDisplayErrorFlag();
        goalSeek.setDisplayInfoFlag('I am in GoalSeek setDisplayErrorFlag');
        goalSeek.getDisplayInfoFlag();
// Execute If Else Conditions...........

        goalSeek=new GoalSeek();
        //When Target Revenue==''
        goalSeek.setTargetrevenue('');
        goalSeek.setClasstype('Economy');
        goalSeek.setQuarter('1');
        goalSeek.estimate();
        //When Target Revenue<0
        goalSeek=new GoalSeek();
        goalSeek.setTargetrevenue('-10');
        goalSeek.setClasstype('Economy');
        goalSeek.setQuarter('1');
        goalSeek.estimate();
        //When Target Revenue is non number
        
        goalSeek=new GoalSeek();
        goalSeek.setTargetrevenue('yashavant');
        goalSeek.setClasstype('Economy');
        goalSeek.setQuarter('1');
        goalSeek.estimate();
        
        
        GoalSeek.RevenueData revenueData=new GoalSeek.RevenueData();
        revenueData.getAgentId();
        revenueData.getNumberOfTicketSold();
        revenueData.getPriceOfTicket();
        
        
        
        
        
        
        
        
        
        
        
    }

}