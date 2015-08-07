public class Scenario {

    public String getCommission() {
        return null;
    }


        String selectedmetric ;
        String selectedcriteria;
        String percent;
        String selectedoption;
  
        public PageReference test() {
                return null;
        }
  
        public List<SelectOption> getMetrictypes() {
                List<SelectOption> metrictypes = new List<SelectOption>();
                metrictypes.add(new SelectOption('Agent Revenue','Agent Revenue'));
                metrictypes.add(new SelectOption('Passenger Traffic','Passenger Traffic'));
                //options.add(new SelectOption('MEXICO','Mexico'));
                return metrictypes;
        }
        
         public List<SelectOption> getCriteria() {
                List<SelectOption> criteria = new List<SelectOption>();
                criteria.add(new SelectOption('Grows By','Grows By'));
               criteria.add(new SelectOption('Declines By','Declines By'));
                //options.add(new SelectOption('MEXICO','Mexico'));
                return criteria;
        }
         public List<SelectOption> getOptions() {
                List<SelectOption> options = new List<SelectOption>();
                options.add(new SelectOption('For All Agents','For All Agents'));
               options.add(new SelectOption('For Selected Agents','For Selected Agents'));
                //options.add(new SelectOption('MEXICO','Mexico'));
                return options;
        }
  
        public String getSelectedmetric() {
                return selectedmetric;
        }
  
        public void setSelectedmetric (String selectedmetric ) {
                this.selectedmetric = selectedmetric ;
        }
        public String getSelectedcriteria() {
                return selectedcriteria;
        }
  
        public void setSelectedcriteria (String selectedcriteria ) {
                this.selectedcriteria = selectedcriteria ;
        }
        public String getPercent(){
           return percent;
        }
        
        public void setPercent(String percent){
          this.percent = percent;
        }
        public String getSelectedoption(){
           return selectedoption;
        }
        
        public void setSelectedoption(String selectedoption){
          this.selectedoption = selectedoption;
        }
          
}