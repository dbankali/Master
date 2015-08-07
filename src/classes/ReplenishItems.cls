public class ReplenishItems{
  
/*        String[] selectedItems= new String[]{};
        String[] selectedLocations= new String[]{};
        String message=null;
        List<Item__c> items;  
        List<Location__c> locations; 
                
         public PageReference moveselItems(){
         
           return null;
         
         }
          public PageReference removeselItems(){
           
          return null;
          }
          
           public PageReference moveallitems(){
           
           return null;
           }
           
            public PageReference removeallItems(){
            
            return null;
            }        
                
        public PageReference save() {
            Boolean flag=true;
            for(Integer i=0;i<selectedLocations.size();i++){
                System.debug(selectedLocations[i]);
                for(Integer j=0;j<selectedItems.size();j++){
                    System.debug(selectedItems[j]);
                    Item_location__c obj=new Item_location__c(Location_Name__c=selectedLocations[i],Item_Name__c=selectedItems[j]);
                    try{
                        if(!this.isPresent(selectedLocations[i],selectedItems[j])){
                            insert obj;
                        }else{
                            flag=false;
                            this.setMessage('Record is already present.');
                            break; 
                        }
                    }catch(Exception e){
                          flag=false;
                          this.setMessage('Record is not inserted.');
                          break;  
                    }
                }
                if(flag==false){
                    break;
                }
            }
            if(flag){
                this.setMessage('Record is inserted successfully.');  
            }
            return null;
        }
        
        public void setMessage(String message){
            this.message=message;
        }
        public String getMessage(){
            return message;
        }
                
        public List<SelectOption> getItems() {
                List<SelectOption> options = new List<SelectOption>();
                Integer i=0;
                for(Item__c itemi: [select id,Item_Name__c from Item__c])
                {
                    options.add(new SelectOption(itemi.id,itemi.Item_Name__c));
                }
                return options;
        }
  
        public String[] getselectedItems() {
                return selectedItems;
        }
  
        public void setselectedItems(String[] selectedItems) {
                this.selectedItems= selectedItems;
        }
       public List<SelectOption> getLocations() {
                List<SelectOption> options = new List<SelectOption>();
                Integer i=0;
                for(Location__c location: [select id,Location_Name__c from Location__c ])
                {
                    options.add(new SelectOption(location.id,location.Location_Name__c));
                }
                return options;
        }
  
        public String[] getselectedLocations() {
                return selectedLocations;
        }
  
        public void setselectedLocations(String[] selectedLocations) {
                this.selectedLocations= selectedLocations;
        }
        
        public Boolean isPresent(String locationId,String itemId) {
            Boolean flag=false;
            for(Item_location__c itloc : [select id from Item_location__c where Location__c = : locationId and ItemN__c =: itemId])
            {
                flag=true;
            }
            return flag;
        }*/
        
  }