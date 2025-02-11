/**
 * This is a utility class to help test HTTP callouts.
 * 
 * @author Olavo Alexandrino <oalexandrino@gmail.com>
 */
global class MockHttpResponseHandler implements HttpCalloutMock {

    public static final String NO_RESPONSE_FOUND_MESSAGE = 'No response for endpoint: {ENDPOINT}';

    /**
     * @description Each endpoint gets a ResponseEndpointHandler that stores a list of responses for each method
     */
    private Map<String,ResponseEndpointHolder> responseHolderMap = new Map<String,ResponseEndpointHolder>();

    /**
     * @description This causes the ? query params to be ignored when routing responses
     * By default, incoming request will be mapped only using the base URL.  
     * You can change this behavoir if needed by setting this.ignoreQuery to true.
     */
    public Boolean ignoreQuery {get; set;}

    public MockHttpResponseHandler(){
        this.ignoreQuery = true;
    }

    /**
     * @description interface method for HttpCalloutMock
     * @return return HTTPResponse
     */
    global HTTPResponse respond(HTTPRequest req) {
        String endpoint = req.getEndpoint();
        System.debug('Responding to the following endpoint: ' + endpoint);
       
        endpoint = getEndpointKey(endpoint);

        if(!this.responseHolderMap.containsKey(endpoint)){
            throw new HttpCalloutMockException(NO_RESPONSE_FOUND_MESSAGE.replace('{ENDPOINT}', endpoint));
        }
        ResponseEndpointHolder responseHolder = this.responseHolderMap.get(endpoint);
        return responseHolder.respond(req);
    }    

    /**
     * Adds a mock response for the specified endpoint.
     * 
     * @param endpoint The endpoint for which the mock response is being added. Only 1 endpoint is allowed per mock, but several mocks can be added to the same endpoint.
     * @param response The mock response to be added.
     */
    public void addResponse(String endpoint, IMockResponse response){
        endpoint = getEndpointKey(endpoint);
        ResponseEndpointHolder holder = this.getResponseEndpointHolder(endpoint);
        holder.addResponse(response);
    }

    /**
     * Retrieves the ResponseEndpointHolder object for the specified endpoint.
     * 
     * @param endpoint The endpoint for which to retrieve the ResponseEndpointHolder.
     * @return The ResponseEndpointHolder object associated with the specified endpoint.
     */
    private ResponseEndpointHolder getResponseEndpointHolder(String endpoint)
    {
        ResponseEndpointHolder holder;
        if(this.responseHolderMap.containsKey(endpoint)){
            holder = this.responseHolderMap.get(endpoint);
        }else{
            holder = new ResponseEndpointHolder();
            this.responseHolderMap.put(endpoint, holder);
        }   
        return holder;
    }    

    /**
     * Returns the key for the given endpoint.
     * 
     * @param endpoint The endpoint for which to get the key.
     * @return The key for the given endpoint.
     */
    private String getEndpointKey(String endpoint){
        return (this.ignoreQuery) ? getBaseUrl(endpoint): endpoint;
    }    

    /**
     * Returns the base URL for the given endpoint.
     * 
     * @param endpoint The endpoint for which the base URL is needed.
     * @return The base URL for the given endpoint.
     */
    private String getBaseUrl(String endpoint){
        Url baseUrl = new URL(endpoint);
        return baseUrl.getHost() + baseUrl.getPath();
    }
}