/**
 * This class represents a holder for mapping endpoint URLs to a list of mock responses.
 * Endpoint Handler is used to store a list of reponses for each HTTP method on an endpoint 
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
    private void validateResponses(List<IMockResponse> responses, String method) {
        if (responses == null || responses.isEmpty()) {
            throw new MockHttpHandlerException('No response for method:' + method);
        }
    }

    /**
     * Returns a mock HTTP response for the given HTTP request.
     * 
     * @param req The HTTP request for which to generate a mock response.
     * @return The mock HTTP response.
     */
    public HTTPResponse respond(HTTPRequest req) {
        HTTPResponse response;
        String method = req.getMethod();
        List<IMockResponse> responses = endpointMethodMap.get(method);
        
        validateResponses(responses, method);

        if (responses.size() == 1) {
            response = responses[0].getResponse(req);
        } else {
            response = responses.remove(0).getResponse(req);
        }
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
            throw new MockHttpHandlerException('Method cannot be null!');
        }

        if (endpointMethodMap.containsKey(method)) {
            endpointMethodMap.get(method).add(response);
        } else {
            endpointMethodMap.put(method, new List<IMockResponse>{response});
        }
    }
}