public class ReplenishableLocations2 {

String message =  null;

Public List<Item__c> getItems(){
List<Item__c> items = new List<Item__c>();
items = [select Item_Name__c from Item__c order by Item_Name__c];
if(items == null){
  this.setmessage('Currently there are no Items to Display, Please add items');
}
return items;

}
public List<Location__c> getLocations(){
List<Location__C> locations = new List<Location__c>();
locations = [select Location_Name__c from Location__c order by Location_Name__c];
if(locations==null){
  this.setMessage('There are no Locations added to display, Please add Locations');
}
return locations;
}

public List<Item_Location__c> getItemLocations(){
List<Item_Location__c> itemlocation = new List<Item_Location__c>();
itemlocation = [select Item_Name__c,Location_Name__c from Item_Location__c ];
return itemlocation;
}

public void setmessage(String s){
  this.message = s;
}
public String getMessage(){
  return this.message;
}



}