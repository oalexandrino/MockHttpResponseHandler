@IsTest
public with sharing class ChainCEPCallsTest {
    @isTest 
    static void testSimpleCall() 
    {
        String URL_MOCK_SP = 'https://viacep.com.br/ws/'+ViaCEPServiceTest.CEP_SP+'/json/';
        String URL_MOC_RECIFE = 'https://viacep.com.br/ws/'+ViaCEPServiceTest.CEP_RECIFE+'/json/';
        String URL_MOCK_POA = 'https://viacep.com.br/ws/'+ViaCEPServiceTest.CEP_POA+'/json/';

        MockHttpResponseHandler mock = new MockHttpResponseHandler();

        //going to run this one twice...
        SimpleMockResponse oSimpleMockResponseSP = new SimpleMockResponse('GET', ViaCEPServiceTest.MOCK_SP, 200, 'OK');
        SimpleMockResponse oSimpleMockResponseRECIFE = new SimpleMockResponse('GET', ViaCEPServiceTest.MOCK_RECIFE, 200, 'OK');
        SimpleMockResponse oSimpleMockResponsePOA = new SimpleMockResponse('GET', ViaCEPServiceTest.MOCK_POA, 200, 'OK');

        mock.addResponse(URL_MOCK_SP, oSimpleMockResponseSP);
        mock.addResponse(URL_MOC_RECIFE, oSimpleMockResponseRECIFE);
        mock.addResponse(URL_MOCK_POA, oSimpleMockResponsePOA);

        Test.startTest();

            Test.setMock(HttpCalloutMock.class, mock);
        
            List<Map<String, Object>> chainList = ChainCEPCalls.run(
                ViaCEPServiceTest.CEP_SP,
                ViaCEPServiceTest.CEP_RECIFE,
                ViaCEPServiceTest.CEP_POA
            );

        Test.stopTest();

        List<String> ceps = new List<String>{'01002-020','50030-903', '90010-030'};

        Integer i = 0;
        for (Map<String, Object> item : chainList) 
        {
            System.assertEquals(ceps[i], item.get('cep'));
            System.debug('item: ' + item.get('cep'));
            System.debug('item: ' + item.get('logradouro'));
            System.debug('item: ' + item.get('bairro'));
            System.debug('item: ' + item.get('localidade'));
            System.debug('item: ' + item.get('uf'));
            System.debug('item: ' + item.get('ibge'));
            System.debug('item: ' + item.get('gia'));
            System.debug('item: ' + item.get('ddd'));
            System.debug('item: ' + item.get('siafi'));    
            i++;
        }
 
    }
}