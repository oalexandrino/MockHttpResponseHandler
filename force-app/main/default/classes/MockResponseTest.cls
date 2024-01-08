
/**
 * @author Olavo Alexandrino <oalexandrino@gmail.com>
 */
@isTest
public class MockResponseTest {

    @isTest
    static void testGetResponseAndSetMethod() {

        Test.startTest();

            HTTPRequest httpRequest = new HTTPRequest();
            httpRequest.setMethod(MockResponseDataFactory.RESPONSE_GET_METHOD);        

            MockResponse mockResponse1 = MockResponseDataFactory.getDefaultMockResponse();
            mockResponse1.setMethod(MockResponseDataFactory.RESPONSE_GET_METHOD);
            HTTPResponse httpResponse1 = mockResponse1.getResponse(httpRequest);    

            MockResponse mockResponse2 = new MockResponse(
                MockResponseDataFactory.RESPONSE_GET_METHOD, 
                MockResponseDataFactory.RESPONSE_BODY, 
                MockResponseDataFactory.RESPONSE_STATUS_CODE, 
                MockResponseDataFactory.RESPONSE_STATUS
            );
            HTTPResponse httpResponse2 = mockResponse2.getResponse(httpRequest);

            MockResponse mockResponse3 = new MockResponse(
                MockResponseDataFactory.RESPONSE_POST, 
                MockResponseDataFactory.RESPONSE_BODY, 
                MockResponseDataFactory.RESPONSE_STATUS_CODE, 
                MockResponseDataFactory.RESPONSE_STATUS, 
                MockResponseDataFactory.CONTENT_TYPE, 
                MockResponseDataFactory.RESPONSE_HEADERS
            );
            mockResponse3.setMethod(MockResponseDataFactory.RESPONSE_POST);        
            HTTPResponse httpResponse3 = mockResponse3.getResponse(httpRequest);    

        Test.stopTest();

        System.assertEquals(MockResponseDataFactory.RESPONSE_BODY, httpResponse1.getBody(), 'Message if assertion fails');
        System.assertEquals(200, httpResponse1.getStatusCode(), 'Message if assertion fails');
        System.assertEquals(MockResponseDataFactory.RESPONSE_STATUS, httpResponse1.getStatus(), 'Message if assertion fails');
        System.assertEquals(MockResponseDataFactory.CONTENT_TYPE, httpResponse1.getHeader('Content-Type'), 'Message if assertion fails');
        System.assertEquals(null, httpResponse1.getHeader('Header1'), 'Message if assertion fails');
        System.assertEquals(MockResponseDataFactory.RESPONSE_GET_METHOD, mockResponse1.getMethod(), 'Must be ' +MockResponseDataFactory.RESPONSE_GET_METHOD);

        System.assertEquals(MockResponseDataFactory.RESPONSE_BODY, httpResponse2.getBody(), 'Message if assertion fails');
        System.assertEquals(200, httpResponse2.getStatusCode(), 'Message if assertion fails');
        System.assertEquals(MockResponseDataFactory.RESPONSE_STATUS, httpResponse2.getStatus(), 'Message if assertion fails');
        System.assertEquals(MockResponseDataFactory.CONTENT_TYPE, httpResponse2.getHeader('Content-Type'), 'Message if assertion fails');
        System.assertEquals(null, httpResponse2.getHeader('Header1'), 'Message if assertion fails');
        System.assertEquals(MockResponseDataFactory.RESPONSE_GET_METHOD, mockResponse2.getMethod(), 'Must be ' +MockResponseDataFactory.RESPONSE_GET_METHOD);
        
        System.assertEquals(MockResponseDataFactory.RESPONSE_BODY, httpResponse3.getBody(), 'Message if assertion fails');
        System.assertEquals(200, httpResponse3.getStatusCode(), 'Message if assertion fails');
        System.assertEquals(MockResponseDataFactory.RESPONSE_STATUS, httpResponse3.getStatus(), 'Message if assertion fails');
        System.assertEquals(MockResponseDataFactory.CONTENT_TYPE, httpResponse3.getHeader('Content-Type'), 'Message if assertion fails');
        System.assertEquals(MockResponseDataFactory.HEADERS_VALUE, httpResponse3.getHeader('Header1'), 'Message if assertion fails');   
        System.assertEquals(MockResponseDataFactory.RESPONSE_POST, mockResponse3.getMethod(), 'Must be ' +MockResponseDataFactory.RESPONSE_POST);     
    }

    @isTest
    static void testCheckRequestProperties() {

        Test.startTest();

            MockResponse mockResponse1 = MockResponseDataFactory.getDefaultMockResponse();
            MockResponse mockResponse2 = MockResponseDataFactory.getDefaultMockResponse();
            MockResponse mockResponse3 = MockResponseDataFactory.getDefaultMockResponse();

            HttpCalloutMockException expectedException1 = null;
            HttpCalloutMockException expectedException2 = null;
            HttpCalloutMockException expectedException3 = null;        

            mockResponse1.contentType = null;
            mockResponse2.statusCode = null;
            mockResponse3.status = null;
            try {
                mockResponse1.checkRequestProperties();
            } catch (HttpCalloutMockException e) {
                expectedException1 = e;
            }

            try {
                mockResponse2.checkRequestProperties();
            } catch (HttpCalloutMockException e) {
                expectedException2 = e;
            }
            
            try {
                mockResponse3.checkRequestProperties();
            } catch (HttpCalloutMockException e) {
                expectedException3 = e;
            }            

        Test.stopTest();

        System.assertEquals(MockResponse.CONTENT_TYPE_NOT_PROVIDED_MESSAGE, expectedException1.getMessage(), 'Message must be: ' + MockResponse.CONTENT_TYPE_NOT_PROVIDED_MESSAGE);
        System.assertEquals(MockResponse.STATUS_CODE_NOT_PROVIDED_MESSAGE, expectedException2.getMessage(), 'Message must be: ' + MockResponse.STATUS_CODE_NOT_PROVIDED_MESSAGE);
        System.assertEquals(MockResponse.STATUS_NOT_PROVIDED_MESSAGE, expectedException3.getMessage(), 'Message must be: ' + MockResponse.STATUS_NOT_PROVIDED_MESSAGE);
    }
}