public class LinkedInAPI{

public pageReference login(){

  HTTPRequest req = new HTTPRequest();
  req.setMethod('POST');
  req.setHeader('content-type','text/html');
  req.setHeader('Host','api.linkedin.com');
  req.setEndpoint('https://api.linkedin.com/uas/oauth/requestToken');
  //req.setBody();
   Http http = new Http();
   try{
    HttpResponse res = http.send(req);
    system.debug(res.toString());
   
   }catch(System.CalloutException e){
      System.debug('Callout Exception');
   }
  
  return null;
 
}

}