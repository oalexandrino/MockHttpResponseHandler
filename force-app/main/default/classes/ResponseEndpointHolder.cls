/**
 * Endpoint Handler is used to store a list of reponses for each HTTP method on an endpoint 
 */
public class ResponseEndpointHolder{
    protected Map<String, List<IMockResponse>> endpointMethodMap = new Map<String, List<IMockResponse>>();

    public HTTPResponse getMockResponse(HTTPRequest req){
        HTTPResponse response;
        String method = req.getMethod();
        List<IMockResponse> responses = endpointMethodMap.get(method);
        if(responses == null || responses.size() == 0){
            throw new MockHttpHandlerException('No response for method:' + method);
        }
        
        if(responses.size() == 1){
            response = responses[0].getResponse(req);
        }else{
            response = responses.remove(0).getResponse(req);
        }
        return response;
    }

    public void addMockResponse(IMockResponse response){
        String method = response.getMethod();
        if(method == null){
            throw new MockHttpHandlerException('Method cannot be null!');
        }

        if(endpointMethodMap.containsKey(method)){
            endpointMethodMap.get(method).add(response);
        }else{
            endpointMethodMap.put(method, new List<IMockResponse>{ response });
        }
    }
}