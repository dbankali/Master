global class Simlib{     
       
  WebService static String getContent(String content)  
    {
        String response = '';
        
        // Instantiate a new http object
        Http h = new Http();
               
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req = new HttpRequest();
        String url = 'https://test.authorize.net/gateway/transact.dll';
        req.setEndpoint(url);
        req.setMethod('POST');
        String body = content;
        req.setBody(body);
        
       
        // Send the request, and return a response
        HttpResponse res = h.send(req);
        return res.getBody();               
     }
     
     


}