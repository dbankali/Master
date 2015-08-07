public class testcontroller {
String name;
Integer empId;

 String country ;

public String getName(){
  return this.name;
} 
public void setName(String name){
  this.name = name;
}
public Integer getEmpId(){
  return this.empId;
}
public void setEmpId(Integer empId){
   this.empId = empId;
}
public List<SelectOption> getItems() {
                List<SelectOption> options = new List<SelectOption>();
                options.add(new SelectOption('US','US'));
                options.add(new SelectOption('CANADA','Canada'));
                options.add(new SelectOption('MEXICO','Mexico'));
                return options;
        }
        public String getCountry() {
                return country;
        }
  
        public void setCountry(String country) {
                this.country = country;
        }
        



}