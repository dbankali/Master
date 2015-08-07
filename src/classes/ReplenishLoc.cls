public class ReplenishLoc{

 /*       Boolean moveRightitems = false;
  
        String[] selectedItems= new String[]{};
        String[] selectedLocations= new String[]{};
        String[] selectedItems2= new String[]{};
        String[] selectedLocations2= new String[]{};
        String message=null;
        
        List<Item__c> items;  
        List<Location__c> locations; 
        List<SelectOption> selItemsoptions = new List<SelectOption>();
        List<SelectOption> itemoptions = new List<SelectOption>();
        
         public PageReference moveRightItems(){
           moveRightitems  = true;
         List<SelectOption> refine = new List<SelectOption>();
         List<SelectOption> refineselected = new List<SelectOption>();
         itemoptions.clear();
          String[] selvalues = new String[]{};
          selvalues  = selectedItems;
          if(selvalues!=null){                    
          for(String str: selvalues){
              Integer i =0;
             selItemsoptions.add(new SelectOption(selvalues[i],selvalues[i])); 
             refineselected.add(new SelectOption(selvalues[i],selvalues[i]));         
             i = i+1;
          }  
          }
          //if(itemoptions.size()>selItemsoptions.size()){
               for(SelectOption iteritem:itemoptions){
                  integer i = 0;
                  String myitem =  itemoptions.get(i).getValue();
                  for(SelectOption iterselItem: refineselected){
                  integer j =0;
                  String selItem =  selItemsoptions.get(j).getValue();
                  if(myitem.equals(selItem)){
                     itemoptions.remove(i);
                  }
                  j = j+1;
               }
                  i = i+1;
               }
               
            selectedItems = null;
          
          //}else if(itemoptions.size()<selItemsoptions.size()){
          
          
          //}        
          
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
                    Item_location__c obj=new Item_location__c(Location__c=selectedLocations[i],Item__c=selectedItems[j]);
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
                if(!moveRightitems){
                Integer i=0;
                for(Item__c itemi: [select id,Item_Name__c from Item__c])
                {
                    itemoptions.add(new SelectOption(itemi.Item_Name__c,itemi.Item_Name__c));
                }
                }
                return itemoptions;
        }
        public List<SelectOption> getselItemsoptions(){
                   return selItemsoptions;        
        }
        public String[] getselectedItems() {
                return selectedItems;
        }
  
        public void setselectedItems(String[] selectedItems) {
                this.selectedItems= selectedItems;
        }
         public String[] getselectedItems2() {
                return selectedItems2;
        }
  
        public void setselectedItems2(String[] selectedItems2) {
                this.selectedItems2= selectedItems2;
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
        public String[] getselectedLocations2() {
                return selectedLocations2;
        }
  
        public void setselectedLocations2(String[] selectedLocations2) {
                this.selectedLocations2= selectedLocations;
        }

        
        public Boolean isPresent(String locationId,String itemId) {
            Boolean flag=false;
            for(Item_location__c itloc : [select id from Item_location__c where Location__c = : locationId and Item__c =: itemId])
            {
                flag=true;
            }
            return flag;
        }
   */     
  }