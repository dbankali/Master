public class trial {
Interviewer__c input = new Interviewer__c();
String emp;
public Interviewer__c getinput(){
   return this.input;
}
 
public pagereference submit(){
  String empl = String.valueof(input.Employee__c);
  this.setEmp(String.valueof(empl));
 return null;
}

public void setEmp(String s){
  this.emp = s;
}

public String getEmp(){
return this.emp;
}

}