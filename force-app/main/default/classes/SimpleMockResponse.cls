/**
 * Base class that covers most simple use cases
 */
public virtual class SimpleMockResponse implements IMockResponse{

    public String contentType { get; set;}
    public Integer statusCode {get; set;}
    public Map<String, String> headers {get; set;}
    public String body {get; set;}
    private String method;
    private String status;

    public String getMethod(){
        return method;
    }

    public void setMethod(String value){
        this.method = value;
    }

    public SimpleMockResponse(String method, String body, Integer statusCode, String status){
        this.headers = new Map<String, String>();
        this.method = method;
        this.body   = body;
        this.statusCode = statusCode;
        this.status = status;
        this.contentType = 'application/json';
        this.headers = headers;
    }       

    public SimpleMockResponse(String method, String body, Integer statusCode, String contentType, Map<String, String> headers){
        this.method = method;
        this.body   = body;
        this.statusCode = statusCode;
        this.contentType = contentType;
        this.headers = headers;
    }      

    public SimpleMockResponse(String method, String body){
        this.headers = new Map<String, String>();
        this.method = method;
        this.body = body;
        this.statusCode = 200;
        this.contentType = 'application/json';
    }    

    public HTTPResponse getResponse(HTTPRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', this.contentType);
        if(this.body != null){
            res.setBody(this.body);
        }
        res.setStatusCode(this.statusCode);
        res.setStatus(this.status);
        for(String key :this.headers.keySet()){
            res.setHeader(key, this.headers.get(key));
        }

        return res;
    }
}