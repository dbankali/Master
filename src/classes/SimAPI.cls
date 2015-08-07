public class SimAPI {
  private String authNetID ='6zz6m5N4Et';

     String fingerprintSequence ;

    String fingerprintTimestamp;

    String price='19.9';

     String currencyCode='$';

    String transactionKey='9V9wUv6Yd92t27t5';
    
    

    public void setAuthNetID(String authNetID ) {
        this.authNetID = authNetID ;
    }
    public String getAuthNetID(){
      return  this.authNetID;
      } 
      

    public void setFingerprintSequence(String fingerprintSequence ) {
        this.fingerprintSequence = fingerprintSequence ;
    }
    public String getFingerPrintSequence(){
       return this.fingerprintSequence ;
    }

    public void setFingerprintTimestamp(String fingerprintTimestamp ) {
        this.fingerprintTimestamp = fingerprintTimestamp ;
    }
    
    public String getFingerprintTimestamp(){
      return this.fingerprintTimestamp ;    
    }

    public void setPrice(String price ) {
        this.price = price ;
    }
    
    public String getPrice(){
       return this.price ;
    }

    public void setCurrencyCode(String currencyCode ) {
        this.currencyCode = currencyCode ;
    }
    public String getCurrencyCode(){
    return this.currencyCode;
    }

    public void setTransactionKey(String transactionKey ) {
        this.transactionKey = transactionKey ;
    }
    public String getTransactionKey(){
      return this.transactionKey;
    }
    public void setResponse(String response){
  this.response = response;
}
public String getResponse(){
  return this.response;
}
    public PageReference action(){   
   
fingerprintSequence = Crypto.getRandomInteger().format();
Long millisecs =  System.currentTimeMillis()/1000;
fingerprintTimestamp  = millisecs.format();
String content = '&x_login='+this.authNetID+'&x_version=3.1&x_test_request=TRUE&x_method=CC&x_type=AUTH_CAPTURE&x_amount='+this.price+'&x_show_form=PAYMENT_FORM&x_fp_sequence='+fingerprintSequence+'&x_fp_timestamp='+fingerprintTimestamp+'&x_trans_id='+this.transactionKey+'&x_relay_response=FALSE';     
String algorithmName = 'MD5';
String myData = '6zz6m5N4Et^'+fingerprintSequence +'^'+fingerprintTimestamp+'^'+price+'^';
Blob hash = Crypto.generateDigest('MD5',Blob.valueOf(myData));
String hexDigest = EncodingUtil.convertToHex(hash);
System.debug(hexDigest);
System.debug('fingerprintSequence '+fingerprintSequence );
System.debug('fingerprintTimestamp  '+fingerprintTimestamp  );
HttpRequest req = new HttpRequest();
content = content+'&x_fp_hash='+hexDigest;
String endpoint = 'https://secure.authorize.net/gateway/transact.dll';
req.setEndpoint(endpoint);
req.setMethod('POST'); 
req.setBody(content);
Http http = new Http();

HttpResponse res = http.send(req);
this.setResponse(res.getBody());
System.debug('STATUS:'+res.getStatus());
System.debug('STATUS_CODE:'+res.getStatusCode());
System.debug('BODY: '+res.getBody());
return null;

}

String response;

  

}