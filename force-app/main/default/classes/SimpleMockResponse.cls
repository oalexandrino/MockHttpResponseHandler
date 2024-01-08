/**
 * Base class that covers most simple use cases
 */
public virtual class SimpleMockResponse implements IMockResponse{

    public String contentType { get; set;}
    public Integer statusCode {get; set;}
    public String body {get; set;}
    private String method;
    private String status;
    public Map<String, String> headers {get; set;}    

    public String getMethod(){
        return method;
    }

    public void setMethod(String value){
        this.method = value;
    }

    /**
     * Constructor for creating a SimpleMockResponse object.
     * 
     * @param method The HTTP method for which the mock response is being created.
     * @param body The response body for the mock response.
     * @param statusCode The HTTP status code for the mock response.
     * @param status The HTTP status message for the mock response.
     */
    public SimpleMockResponse(String method, String body, Integer statusCode, String status){
        this.headers = new Map<String, String>();
        this.method = method;
        this.body   = body;
        this.statusCode = statusCode;
        this.status = status;
        this.contentType = 'application/json';
        this.headers = headers;
    }       

    /**
     * Constructor for creating a SimpleMockResponse object.
     * 
     * @param method The HTTP method for the mock response.
     * @param body The response body for the mock response.
     * @param statusCode The HTTP status code for the mock response.
     * @param contentType The content type for the mock response.
     * @param headers The headers for the mock response.
     */
    public SimpleMockResponse(String method, String body, Integer statusCode, String contentType, Map<String, String> headers){
        this.method = method;
        this.body   = body;
        this.statusCode = statusCode;
        this.contentType = contentType;
        this.headers = headers;
    }      

    /**
     * Constructor for the SimpleMockResponse class.
     * 
     * @param method The HTTP method for the mock response.
     * @param body The body of the mock response.
     */
    public SimpleMockResponse(String method, String body){
        this.headers = new Map<String, String>();
        this.method = method;
        this.body = body;
        this.statusCode = 200;
        this.contentType = 'application/json';
    }    

    /**
     * Returns the HTTP response for the given HTTP request.
     * 
     * @param oHTTPRequest The HTTP request for which the response is needed.
     * @return The HTTP response.
     */
    public HTTPResponse getResponse(HTTPRequest oHTTPRequest) {

        this.checkRequestProperties();

        HttpResponse res = new HttpResponse();
        
        // body can be null
        if(this.body != null){
            res.setBody(this.body);
        }

        res.setHeader('Content-Type', this.contentType);
        res.setStatusCode(this.statusCode);
        res.setStatus(this.status);

        for(String key :this.headers.keySet()){
            res.setHeader(key, this.headers.get(key));
        }

        return res;
    }

    /**
     * Checks the HTTP request against the provided request.
     * 
     * @param oHTTPRequest The HTTP request to be checked.
     */
    private void checkRequestProperties()
    {
        if (this.contentType == null)
        {
            throw new HttpCalloutMockException('HTTPRequest Content-Type is required');
        }

        if (this.statusCode == null)
        {
            throw new HttpCalloutMockException('HTTPRequest statusCode is required');
        }

        if (this.status == null)
        {
            throw new HttpCalloutMockException('HTTPRequest status is required');
        }
    }
}