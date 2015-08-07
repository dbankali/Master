public class exampleCon {
        Integer count = 0;
                       
        public PageReference incrementCounter() {
                count++;
                return null;
        }
                        
        public Integer getCount() {
                return count;
        }
        static testmethod void testcon(){
            User u1 = [select id from User where username='admin@applabde364.com'];
            System.runAs(u1){
              System.debug('Current User'+ UserInfo.getUserName());
              System.debug('Current Profile'+ UserInfo.getProfileId()); 
            }
        }
        boolean flag = false;
        public void setFlag(boolean flag){
          this.flag = flag;
        }
        public boolean getFlag(){
          return this.flag;
        }
        public PageReference trialmeth(){
          this.flag= true;
          return null;
        
        }
}