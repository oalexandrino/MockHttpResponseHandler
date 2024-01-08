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

    /**
     * @description Used example: https://docs.github.com/pt/rest/commits/commits?apiVersion=2022-11-28#get-a-commit
     */
    public static final String URL_GITHUB_ENDPOINT_LIST_BRANCHES = 'https://api.github.com/repos/octocat/Hello-World/commits/6dcb09b5b57875f334f61aebed695e2e4193db5e/branches-where-head'; 
    public static final String URL_GITHUB_ENDPOINT_LIST_BRANCHES_RESPONSE = '{"name":"branch_5","commit":{"sha":"c5b97d5ae6c19d5c5df71a34c7fbeeda2479ccbc","url":"https://api.github.com/repos/octocat/Hello-World/commits/c5b97d5ae6c19d5c5df71a34c7fbeeda2479ccbc"},"protected":false}';

    public static MockResponse getDefaultMockResponse()
    {
        return new MockResponse(MockResponseDataFactory.RESPONSE_GET_METHOD, MockResponseDataFactory.RESPONSE_BODY);
    }

    public static MockResponse geMockResponseForGitHub()
    {
        MockResponse oMockResponseForGitHub = new MockResponse(
            MockResponseDataFactory.RESPONSE_GET_METHOD, 
            MockResponseDataFactory.URL_GITHUB_ENDPOINT_LIST_BRANCHES_RESPONSE, 
            MockResponseDataFactory.RESPONSE_STATUS_CODE, 
            MockResponseDataFactory.RESPONSE_STATUS 
        );

        return oMockResponseForGitHub;
    }
}