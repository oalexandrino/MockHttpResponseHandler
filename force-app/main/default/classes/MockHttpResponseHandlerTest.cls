/**
 * @author Olavo Alexandrino <oalexandrino@gmail.com>
 */
@isTest
public with sharing class MockHttpResponseHandlerTest 
{
    public static final String ENDPOINT_URL = 'https://endpoint.mockable.io/v1/';

    @isTest 
    static void testMockHttpResponseHandler() 
    {
        MockHttpResponseHandler mockHandler = new MockHttpResponseHandler();

        MockResponse mockResponse = MockResponseDataFactory.getDefaultMockResponse();

        // adding twice the same response to code coverage
        mockHandler.addResponse(ENDPOINT_URL,  mockResponse);
        mockHandler.addResponse(ENDPOINT_URL,  mockResponse);

        Test.startTest();

            Test.setMock(HttpCalloutMock.class, mockHandler);
            String body = sendRequest('GET', ENDPOINT_URL);

            String endPointNotFound = 'https://another-endpoint';
            Exception endPointNotFoundExeception = null;
    
            try {
                body = sendRequest('GET', endPointNotFound);
            }
            catch (Exception ex) {
                endPointNotFoundExeception = ex;
            }            

        Test.stopTest();

        System.assertEquals(
            MockResponseDataFactory.RESPONSE_BODY, 
            body, 
            'The response body should be the same as the mock response body'
        );

        String expectedMessage =  MockHttpResponseHandler.NO_RESPONSE_FOUND_MESSAGE.replace('{ENDPOINT}', endPointNotFound.replace('https://', ''));

        System.assertEquals(
            expectedMessage, 
            endPointNotFoundExeception.getMessage(), 
            'Must be: '+ expectedMessage
        );        

    }

    private static String sendRequest(String method, String endpoint){
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod(method);
        Http http = new Http();
        HttpResponse response = http.send(req);
        return response.getBody();
    }    
}