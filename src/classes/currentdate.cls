public class currentdate {
Date mydate;
Integer mon;
 Integer ye;
    public PageReference generate() {
      // setMydate(Date.today());
        return null;
    }


public Integer getMydate(){
 Date mydate = Date.today();
  mon = mydate.month();
  ye = mydate.year();
  return ye;
}
public void setMydate(Date d){
  this.mydate= d;
}


}