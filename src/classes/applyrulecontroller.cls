global class applyrulecontroller{
  
        String[] selectedRules= new String[]{};
        String[] selectedAgents= new String[]{};
        String message=null;
        List<Rule__c> rules;  
        List<Agent__c> agents; 
                
        public PageReference save() {
            Boolean flag=true;
            Integer count = 0;
            System.debug('In save method...');
            for(Integer i=0;i<selectedAgents.size();i++){
                System.debug('I='+i+' Selected AgentId :'+selectedAgents[i]);
                for(Integer j=0;j<selectedRules.size();j++){
                    System.debug('J='+j+' Selected RuleId :'+selectedRules[j]);
                    AgentRule__c obj=new AgentRule__c(LP_Agent_Id__c=selectedAgents[i],LP_Rule_Id__c=selectedRules[j]);
                    try{
                        if(!this.isPresent(selectedAgents[i],selectedRules[j])){
                            insert obj;
                        }else{
                         count = count + 1;
                         if(count == (selectedAgents.size()*selectedRules.size())){
                            flag=false;
                            this.setMessage('Record(s) already present.');
                            break; 
                            }
                        }
                    }catch(Exception e){
                          flag=false;
                          this.setMessage('Record(s) not inserted.');
                          System.debug('Exception :'+e);
                          break;  
                    }
                }
                if(flag==false){
                    break;
                }
            }
            if(flag){
                this.setMessage('Record(s) inserted successfully.');  
            }
            return null;
        }
        
        public void setMessage(String message){
            this.message=message;
        }
        public String getMessage(){
            return message;
        }
                
        public List<SelectOption> getRules() {
                List<SelectOption> options = new List<SelectOption>();
                Integer i=0;
                System.debug('In getRules method...');
                for(Rule__c rule : [select id,RuleName__c from Rule__c where RuleName__c != 'Basic Commission'])
                {
                    options.add(new SelectOption(rule.id,rule.RuleName__c));
                }
                return options;
        }
  
        public String[] getSelectedRules() {
                return selectedRules;
        }
  
        public void setSelectedRules(String[] selectedRules) {
                this.selectedRules= selectedRules;
        }
       public List<SelectOption> getAgents() {
                List<SelectOption> options = new List<SelectOption>();
                Integer i=0;
                System.debug('In getAgents method...');
                for(Agent__c agent : [select id,AgentName__c from Agent__c ])
                {
                    options.add(new SelectOption(agent.id,agent.AgentName__c));
                }
                return options;
        }
  
        public String[] getSelectedAgents() {
                return selectedAgents;
        }
  
        public void setSelectedAgents(String[] selectedAgents) {
                this.selectedAgents= selectedAgents;
        }
        
        public Boolean isPresent(String agentId,String ruleId) {
            Boolean flag=false;
            System.debug('In isPresent method...');
            for(AgentRule__c agRule : [select id from AgentRule__c where LP_Agent_Id__c = : agentId and LP_Rule_Id__c =: ruleId])
            {
                flag=true;
            }
            return flag;
        }
        
  }