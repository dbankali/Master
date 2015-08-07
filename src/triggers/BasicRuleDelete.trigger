trigger BasicRuleDelete on Rule__c (before delete) {

for(Rule__c r :Trigger.old)
{if(r.RuleName__c=='Basic Commission')
{r.addError('Cannot delete the Basic Commission Rule');}
}
}