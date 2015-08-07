public class Actionsupportexample {
         
            
            String uname;
            
            public String getUsername() {
            return uname;
            }
            
            public PageReference sayHello() {
            uname = UserInfo.getName();
            return null;
            }
            
            public void setState(String n) {
            state = n;
            }
            
            public String getState() {
            return state;
            }
            
            public PageReference methodOne() {
            // String s='Anil';
            return null;
            }
            
            private String state = 'no';
            }