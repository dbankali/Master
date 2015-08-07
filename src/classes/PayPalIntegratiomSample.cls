public with sharing class PayPalIntegratiomSample {
	public HttpRequest getRequest(){
		HttpRequest paypalRequest = new HttpRequest();
		paypalRequest.setEndPoint('https://api.sandbox.paypal.com/v1/oauth2/token');
		paypalRequest.setHeader('Accept-Language','en_US' );
		paypalRequest.setHeader('Accept','application/json' );
		paypalRequest.setHeader('content-type','application/x-www-form-urlencoded');
		//paypalRequest.setHeader('Client_id','AZtIoRD46wD2ZXVgCjIzhV62kGFdqILeSOKdbIzsv7W_Us8NcYIHyxOw4Jes' );
		paypalRequest.setHeader('grant_type','client_credentials');
		Blob headerValue = Blob.valueOf('AZtIoRD46wD2ZXVgCjIzhV62kGFdqILeSOKdbIzsv7W_Us8NcYIHyxOw4Jes' + ':' + 'EAdVERDK3OmF8Pxlt1VU7wlh2aYZY_x8tZzqN-XHWnFHqvdqEnBMmY1_qk0f');
		paypalRequest.setHeader('Authorization','BASIC '+EncodingUtil.base64Encode(headerValue));		
		paypalRequest.setMethod('GET');
		system.debug('Request--->>>>'+paypalRequest.getHeader('Authorization'));
		//paypalRequest.setBody('');
		return paypalRequest;
		
	}
	public void sendPayPalRequest(){
		HttpRequest paypalRequest = getRequest();
		Http payPalHttp = new Http();
		HttpResponse response = payPalHttp.send(paypalRequest);
		system.debug('response>>>>>'+response);
	}

}