global class HelloWorld2{
static List<String> myStringList = new List<String>();
    WebService static Integer selected(String[] s){
                   List<String> acc =  new List<String>();
                    Integer i =0;
        for(String temp:s){
        i=i+1;
          acc.add(temp);        
        }
       myStringList = acc;
       return i;
     }
     webservice static List<String> getselected(){
     System.debug(myStringList);
       return myStringList;
     }
     
}