public class simdata {
    String login;
    String trans_key;
    String atype;
    String  amount;
    String card_no;
    String exp_date; 
    String response;   
 
    public void post() {
      String content = 'x_login='+this.login+'&x_tran_key='+this.trans_key+'&x_version=3.1&x_test_request=TRUE&x_method=CC&x_type='+this.atype+'&x_amount='+this.amount+'&x_delim_data=TRUE&x_delim_char=|&x_relay_response=FALSE&x_card_num='+this.card_no+'&x_exp_date='+this.exp_date+'&x_description=Java Transaction&';
        String res =  Simlib.getContent(content); 
        this.setResponse(res);            
        //return null;
    }
    public void setResponse(String res){
      this.response = res;
    }
    public String getResponse(){
    return this.response;
    }
    
    public void setLogin(String login){
      this.login = login;    
    }
    public String getLogin(){
      return this.login;
    }
    public void setTrans_key(String trans_key){
      this.trans_key = trans_key;      
    }
    public String getTrans_key(){
     return this.trans_key;
    }
     public void setAtype(String atype){
      this.atype = atype;      
    }
    public String getAtype(){
     return this.atype;
    }
     public void setAmount(String amount){
      this.amount = amount;      
    }
    public String getAmount(){
     return this.amount;
    }
     public void setCard_no(String card_no){
      this.card_no = card_no;      
    }
    public String getCard_no(){
     return this.card_no;
    }
     public void setExp_date(String exp_date){
      this.exp_date = exp_date;      
    }
    public String getExp_date(){
     return this.exp_date;
    }
    
}