/**
 * @author Olavo Alexandrino <oalexandrino@gmail.com>
 */
@isTest
public with sharing class MockResponseDataFactory 
{
    public static final String RESPONSE_GET_METHOD = 'GET';
    public static final String RESPONSE_POST = 'POST';
    public static final String RESPONSE_BODY = 'Mock Body';
    public static final Integer RESPONSE_STATUS_CODE = 200;
    public static final String RESPONSE_STATUS = 'OK';
    public static final String CONTENT_TYPE = 'application/json';    
    public static final Map<String, String> RESPONSE_HEADERS = new Map<String, String>{'Header1' => 'Value1'};    
    public static final String HEADERS_VALUE = 'Value1';    

    public static MockResponse getDefaultMockResponse()
    {
        return new MockResponse(MockResponseDataFactory.RESPONSE_GET_METHOD, MockResponseDataFactory.RESPONSE_BODY);
    }
}