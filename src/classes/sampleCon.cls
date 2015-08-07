public class sampleCon {

        String[] myitems = new String[]{};
        String[] mylocations = new String[]{};

        public PageReference test() {
                return null;
        }

        public List<SelectOption> getallItems() {
                List<SelectOption> options = new List<SelectOption>();
                List<Item__c> items = new List<Item__c>();
                items = [select Item_Name__c from Item__c];
                for(Item__c i:items)
               { 
                  String value =  i.Item_Name__c; 
                  String label = '\'' + value +'\'';
                  options.add(new SelectOption(value, label));                
                
                }
                 return options;
        }

        public String[] getmyItems() {
                return myitems;
        }

        public void setmyitems(String[] myitem) {
                this.myitems= myitem;
        }
        public List<SelectOption> getallLocations() {
                List<SelectOption> options = new List<SelectOption>();
                List<Location__c> locations = new List<Location__c>();
                locations = [select Location_Name__c from Location__c];
                for(Location__c l:locations )
               { 
                  String value =  l.Location_Name__c; 
                  String label = '\'' + value +'\'';
                  options.add(new SelectOption(value, label));                
                
                }
                 return options;
        }
            public String[] getmyLocations(){
                return mylocations ;
        }

        public void setmyLocations(String[] myLocation){
                this.mylocations = myLocation;
        }



}