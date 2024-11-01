public virtual class HttpService {
    public class Response{
        @AuraEnabled public Integer statusCode { get; set; }
        @AuraEnabled public String responseBody { get; set; }
        
        public Response(Integer statusCode, String responseBody){
            this.statusCode = statusCode;
            this.responseBody = responseBody;
        }
    }
    
    protected Map<string, string> customHeader;
    
    public HttpService(){
        customHeader = new Map<string, string>();
    }
	
    public void setHeader(string key, string value){
        this.customHeader.put(key, value);
    }
    
    public Response doGet(String calloutEndpoint, String api){
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:' + calloutEndpoint + api);
        request.setMethod('GET');
        request.setTimeout(120000);
        this.setHeaders(request);
        
        return HandleResponse(request);
    }
    
    public Response doPost(String calloutEndpoint, String api, Object requestObject){
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:' + calloutEndpoint + api);
        request.setMethod('POST');
        request.setBody(JSON.serialize(requestObject, true));
        request.setTimeout(120000);
        this.setHeaders(request);
        
        return HandleResponse(request);
    }
    
    private void setHeaders(HttpRequest request){
        request.setHeader('Content-Type', 'application/json');
        for (String key : this.customHeader.keySet()){
            request.setHeader(key, this.customHeader.get(key));
        }
    }
    
    private Response HandleResponse(HttpRequest request){
        Http http = new Http();
        try{
            HttpResponse response = http.send(request);
            Integer statusCode = response.getStatusCode();
            String responseBody = response.getBody();
               
            return new Response(statusCode, responseBody);
        }
        catch(Exception e){
            return new Response(-1, e.getMessage());
        }
        
    }
}