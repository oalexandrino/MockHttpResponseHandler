/**
 * This class represents a holder for mapping endpoint URLs to a list of mock responses.
 * Endpoint Handler is used to store a list of reponses for each HTTP method on an endpoint 
 * @author Olavo Alexandrino <oalexandrino@gmail.com>
 */
@isTest
public class ResponseEndpointHolder {

    private Map<String, List<IMockResponse>> endpointMethodMap = new Map<String, List<IMockResponse>>();

    /**
     * Validates the given list of mock responses for a specific HTTP method.
     * 
     * @param responses The list of mock responses to validate.
     * @param method The HTTP method for which the responses are being validated.
     */
    @TestVisible
    private void validateResponses(List<IMockResponse> responses, String method) {
        if (responses == null || responses.isEmpty()) {
            throw new HttpCalloutMockException('No response for method: ' + method);
        }
    }

    /**
     * Returns the HTTPResponse object based on the list of mock responses and the HTTPRequest object.
     * Once a mock is consumed, it will be removed so the next mock in line will run
     * If there is only 1 mock remaining for any given Endpoint/Method combination, it will not be removed
     * 
     * @param responses The list of mock responses.
     * @param oHTTPRequest The HTTPRequest object.
     * @return The HTTPResponse object.
     */
    @TestVisible
    private HTTPResponse getResponse(List<IMockResponse> responses, HTTPRequest oHTTPRequest)
    {
        return (responses.size() == 1) ? responses[0].getResponse(oHTTPRequest) : responses.remove(0).getResponse(oHTTPRequest);

    }

    /**
     * Returns a mock HTTP response for the given HTTP request.
     * 
     * @param oHTTPRequest The HTTP request for which to generate a mock response.
     * @return The mock HTTP response.
     */
    public HTTPResponse respond(HTTPRequest oHTTPRequest) {
        HTTPResponse response;

        System.debug('Method: ' + oHTTPRequest.getMethod());

        List<IMockResponse> responses = endpointMethodMap.get(oHTTPRequest.getMethod());
        validateResponses(responses, oHTTPRequest.getMethod());
        response = getResponse(responses, oHTTPRequest);
        
        System.debug('response.getBody(): ' + response.getBody());
        return response;
    }

    /**
     * Adds a mock response to the ResponseEndpointHolder.
     * 
     * @param response The mock response to be added.
     */
    public void addResponse(IMockResponse response) {
        String method = response.getMethod();
        if (method == null) {
            throw new HttpCalloutMockException('Method cannot be null!');
        }

        if (endpointMethodMap.containsKey(method)) {
            endpointMethodMap.get(method).add(response);
        } else {
            endpointMethodMap.put(method, new List<IMockResponse>{response});
        }
    }
}