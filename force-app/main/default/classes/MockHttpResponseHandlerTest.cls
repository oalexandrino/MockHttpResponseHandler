@isTest
public with sharing class MockHttpResponseHandlerTest 
{
    @isTest 
    static void testSimpleCall() 
    {
        String URL_MOCK_SP = 'https://viacep.com.br/ws/01002020/json/';

        MockHttpResponseHandler mock = new MockHttpResponseHandler();

        //going to run this one twice...
        SimpleMockResponse oSimpleMockResponse = new SimpleMockResponse('GET', ViaCEPServiceTest.MOCK_SP, 200, 'OK');

        mock.addResponse(URL_MOCK_SP, oSimpleMockResponse);

        Test.startTest();

            Test.setMock(HttpCalloutMock.class, mock);
            HttpResponse res = ViaCEPService.query('01002020');
            Map<String, Object> result = ViaCEPService.format(res);     

        Test.stopTest();

        Map<String, Object> objExpectedResult = (Map<String, Object>) JSON.deserializeUntyped(ViaCEPServiceTest.MOCK_SP);

        System.assertEquals(200, res.getStatusCode());
        System.assertEquals(200, result.get('StatusCode'));
        System.assertEquals('OK', result.get('Status'));
        System.assertEquals(objExpectedResult.get('cep'), result.get('cep'));
        System.assertEquals(objExpectedResult.get('logradouro'), result.get('logradouro'));
        System.assertEquals(objExpectedResult.get('complemento'), result.get('complemento'));
        System.assertEquals(objExpectedResult.get('bairro'), result.get('bairro'));
        System.assertEquals(objExpectedResult.get('localidade'), result.get('localidade'));
        System.assertEquals(objExpectedResult.get('uf'), result.get('uf'));        
    }
}