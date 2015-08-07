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
private class applyrulecontrollertest {
    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        applyrulecontroller controller = new applyrulecontroller();
        controller.setMessage('Hello');
        controller.getMessage();
        controller.getAgents();
        controller.getRules();
        String idRule='';
        List<SelectOption> rules = new List<SelectOption>();
        for(Rule__c rule : [select id,RuleName__c from Rule__c where RuleName__c != 'Basic Commission']){
            idRule=rule.id;
            //rules.add(new SelectOption(rule.id,rule.RuleName__c));
        }
        //rules = controller.getRules();
        String idAgent='';
        List<SelectOption> agents = new List<SelectOption>();        
        for(Agent__c agent : [select id,AgentName__c from Agent__c ])
        {
            idAgent=agent.id;
            //agents.add(new SelectOption(agent.id,agent.AgentName__c));
        }
        
        String[] selectedRules= new String[]{idRule};
        String[] selectedAgents= new String[]{idAgent};
      
        
        controller.setSelectedRules(selectedRules);
        controller.getSelectedRules();
        controller.setSelectedAgents(selectedAgents);
        controller.getSelectedAgents();
        
        
        controller.save();
        
               
    }
}