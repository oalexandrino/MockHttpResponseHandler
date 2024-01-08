
/**
 * @author Olavo Alexandrino <oalexandrino@gmail.com>
 */
@isTest
public with sharing class ResponseEndpointHolderTest {

    @isTest
    static void testGetResponseAddResponseAndRespond()
    {
        Test.startTest();

            MockResponse oMockResponseForGitHub = MockResponseDataFactory.geMockResponseForGitHub();
            List<IMockResponse> listIMockResponse = new List<IMockResponse>{ oMockResponseForGitHub };

            HTTPRequest httpRequest = new HTTPRequest();
            httpRequest.setMethod(MockResponseDataFactory.RESPONSE_GET_METHOD);              

            ResponseEndpointHolder oResponseEndpointHolder = new ResponseEndpointHolder();
            oResponseEndpointHolder.addResponse(oMockResponseForGitHub);

            // another mock for testing scenario in addResponse method
            oResponseEndpointHolder.addResponse( oMockResponseForGitHub ); 

            HttpResponse oResponse = oResponseEndpointHolder.getResponse(
                listIMockResponse, 
                httpRequest
            );

            Map<String,Object> responseMap = (Map<String,Object>) System.JSON.deserializeUntyped(oResponse.getBody());

            oMockResponseForGitHub.setMethod(null);

            Exception methodNullException;

            try {
                oResponseEndpointHolder.addResponse(oMockResponseForGitHub);
            }
            catch (HttpCalloutMockException ex) {
                methodNullException = ex;
            }

            HttpResponse oResponseFromRespond = oResponseEndpointHolder.respond(httpRequest);       
            
            Map<String,Object> responseMapFromRespond = (Map<String,Object>) System.JSON.deserializeUntyped(oResponseFromRespond.getBody());


        Test.stopTest();

        System.assertEquals(
            ResponseEndpointHolder.METHOD_CANNOT_BE_NULL_MESSAGE, 
            methodNullException.getMessage(),
            'Must be: ' + ResponseEndpointHolder.METHOD_CANNOT_BE_NULL_MESSAGE
        );          

        System.assertEquals(
            MockResponseDataFactory.RESPONSE_STATUS, 
            oResponse.getStatus(),
            'Must be: ' + MockResponseDataFactory.RESPONSE_STATUS
        );       
        
        System.assertEquals(
            MockResponseDataFactory.RESPONSE_STATUS_CODE, 
            oResponse.getStatusCode(),
            'Must be: ' + MockResponseDataFactory.RESPONSE_STATUS_CODE
        );    
        
        System.assertEquals(
            'branch_5', 
            responseMap.get('name'),
            'Must be: branch_5'
        );    

        System.assertEquals(
            responseMapFromRespond.get('name'), 
            responseMap.get('name'),
            '"responseMapFromRespond" and "responseMap" Must be equals'
        );         
    }

    @isTest
    static void testValidateResponses()
    {
        Test.startTest();

            Exception validateResponsesException = null;

            ResponseEndpointHolder oResponseEndpointHolder = new ResponseEndpointHolder();
            List<IMockResponse> listIMockResponse = new List<IMockResponse>{ MockResponseDataFactory.geMockResponseForGitHub() };

            oResponseEndpointHolder.endpointMethodMap.put(
                MockResponseDataFactory.URL_GITHUB_ENDPOINT_LIST_BRANCHES, 
                listIMockResponse
            );      
            
            // cover validateResponses without errors
            oResponseEndpointHolder.validateResponses(
                listIMockResponse,
                MockResponseDataFactory.RESPONSE_GET_METHOD
            );            

            try {
                listIMockResponse.clear();
                oResponseEndpointHolder.validateResponses(
                    listIMockResponse,
                    MockResponseDataFactory.RESPONSE_GET_METHOD
                );            
            }
            catch (Exception ex) {
                validateResponsesException = ex;
            }  

        Test.stopTest();

        String expectedMessage = ResponseEndpointHolder.NO_RESPONSE_FOUND_MESSAGE.replace('{METHOD_NAME}', MockResponseDataFactory.RESPONSE_GET_METHOD);

        System.assertEquals(
            expectedMessage, 
            validateResponsesException.getMessage(),
            'Message should be: ' +expectedMessage
        );        
    }

}