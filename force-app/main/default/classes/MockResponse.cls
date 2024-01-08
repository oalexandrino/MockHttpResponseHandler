/**
 * Base class that covers most simple use cases
 * Implement another version by extending it or a new class that implements IMockResponse, if you need a specialized Mock Response
 * @author Olavo Alexandrino <oalexandrino@gmail.com>
 */
public virtual class MockResponse implements IMockResponse{

    public static final Integer DEFAULT_STATUS_CODE = 200;
    public static final String DEFAULT_STATUS = 'OK';
    public static final String DEFAULT_CONTENT_TYPE = 'application/json';

    private String contentType { get; set;}
    private Integer statusCode {get; set;}
    private String body {get; set;}
    private String method;
    private String status;
    private Map<String, String> headers {get; set;}    

    /**
     * Returns the HTTP method of the request.
     * 
     * @return The HTTP method of the request.
     */
    public String getMethod(){
        return method;
    }

    /**
     * Sets the HTTP method for the mock response.
     * 
     * @param value The HTTP method to set.
     */
    public void setMethod(String value){
        this.method = value;
    }

    /**
     * Constructor for the MockResponse class.
     * 
     * @param method The HTTP method for the mock response.
     * @param body The body of the mock response.
     */
    public MockResponse(String method, String body){
        this.headers = new Map<String, String>();
        this.method = method;
        this.body = body;
        this.statusCode = DEFAULT_STATUS_CODE;
        this.status = DEFAULT_STATUS;
        this.contentType = DEFAULT_CONTENT_TYPE;
    }      

    /**
     * Constructor for creating a MockResponse object.
     * 
     * @param method The HTTP method for which the mock response is being created.
     * @param body The response body for the mock response.
     * @param statusCode The HTTP status code for the mock response.
     * @param status The HTTP status message for the mock response.
     */
    public MockResponse(String method, String body, Integer statusCode, String status){
        this.method = method;
        this.body   = body;
        this.statusCode = statusCode;
        this.status = status;
        this.contentType = DEFAULT_CONTENT_TYPE;
        this.headers = new Map<String, String>();
    }       

    /**
     * Constructor for creating a MockResponse object.
     * 
     * @param method The HTTP method for the mock response.
     * @param body The response body for the mock response.
     * @param statusCode The HTTP status code for the mock response.
     * @param status The HTTP status message for the mock response.
     * @param contentType The content type for the mock response.
     * @param headers The headers for the mock response.
     */
    public MockResponse(String method, String body, Integer statusCode, String status,  String contentType, Map<String, String> headers){
        this.method = method;
        this.body   = body;
        this.statusCode = statusCode;
        this.status = status;
        this.contentType = contentType;
        this.headers = headers;
    }      

    /**
     * Returns the HTTP response for the given HTTP request.
     * 
     * @param oHTTPRequest The HTTP request for which the response is needed.
     * @return The HTTP response.
     */
    public virtual HTTPResponse getResponse(HTTPRequest oHTTPRequest) {

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
    public virtual void checkRequestProperties()
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