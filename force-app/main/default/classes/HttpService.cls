public virtual class HttpService {
    public class Response{
        public Integer Code { get; set; }
        public String Result { get; set; }
        
        public Response(Integer code, String result){
            this.Code = code;
            this.Result = result;
        }
    }
    
    protected Map<string, string> CustomHeader;
    
    public HttpService(){
        CustomHeader = new Map<string, string>();
    }
	
    public void setHeader(string key, string value){
        this.CustomHeader.put(key, value);
    }
    
    public Response Get(String calloutEndpoint, String api){
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:' + calloutEndpoint + api);
        request.setMethod('GET');
        request.setTimeout(120000);
        this.SetHeaders(request);
        
        return HandleResponse(request);
    }
    
    public Response Post(String calloutEndpoint, String api, Object requestObject){
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:' + calloutEndpoint + api);
        request.setMethod('POST');
        request.setBody(JSON.serialize(requestObject, true));
        request.setTimeout(120000);
        this.SetHeaders(request);
        
        return HandleResponse(request);
    }
    
    private void SetHeaders(HttpRequest request){
        request.setHeader('Content-Type', 'application/json');
        for (String key : this.CustomHeader.keySet()){
            request.setHeader(key, this.CustomHeader.get(key));
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