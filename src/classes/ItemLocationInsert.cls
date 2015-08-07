global class ItemLocationInsert{

  webservice static Integer insertItemloc(String[] items, String[] locations){
         Integer sample = 10;
        Integer count = 0;
        Integer oneD= 0;
        Integer size = (items.size())*(locations.size());
                   oneD = size/200 + 1;         
         system.debug('inside webservice method');
         Integer twoD = 0;
         Integer total = 0;
         List<Item_location__c> itemlocList = new List<Item_location__c>();
         Item_location__c[] itemlocations = new Item_location__c[200];
         for(Integer m=0;m<items.size();m++){
           for(Integer n=0;n<locations.size();n++){ 
                  Item_location__c itemloc = new Item_location__c(Item_Name__c = items[m], Location_Name__c = locations[n], ItemLoc_ExId__c = items[m]+'at'+locations[n]);                 
                   itemlocList.add(itemloc);
                   insert itemloc;
                  //var itemloc = new sforce.SObject("Item_location__c");
                  //itemlocations[count].Item_Name__c = items[m];
                //  itemlocations[count].Location_Name__c = locations[n];
                // itemlocations[count].ItemLoc_ExId__c = items[m]+'at'+locations[n];
              // itemlocations[twoD].push(itemloc);
                 // alert(itemloc);
                 total = total+1;
                  count = count + 1;
                  if(count==200){
                   //Database.SaveResult[] result = Database.Insert(itemlocations,false);
                   //insert itemlocations;
                    twoD = twoD + 1; 
                     count = 0; 
                                    
                  }  else if(total==size){
                  system.debug('itemlocations' +itemlocations);
                      //Database.SaveResult[] result = Database.Insert(itemlocations,false);                  
                      //insert itemlocations;
                    }                
            }
        } 
          return sample;
  }
}