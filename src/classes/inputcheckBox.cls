public class inputcheckBox{
String name= null;
String name1= null;
List<Item__c> items = new List<Item__c>();

public List<Item__c> getItem(){
   items = [select Id,Item_Name__c from Item__c];
   return items;
}
public String getname(){
return this.name;
}
public String getname1(){
 return this.name1;
}
public void setname(String s){
 this.name = s;
}
public void setname1(String s){
 this.name1 = s;
}
public pagereference submit(){
this.setname('Pasha');
this.setname('Pasha');
return null;
}
}