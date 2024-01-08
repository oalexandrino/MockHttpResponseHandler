@IsTest
public with sharing class ChainCEPCallsTest {
    @isTest 
    static void testSimpleCall() 
    {
        String URL_MOCK_SP = 'https://viacep.com.br/ws/'+ViaCEPServiceTest.CEP_SP+'/json/';
        String URL_MOC_RECIFE = 'https://viacep.com.br/ws/'+ViaCEPServiceTest.CEP_RECIFE+'/json/';
        String URL_MOCK_POA = 'https://viacep.com.br/ws/'+ViaCEPServiceTest.CEP_POA+'/json/';
        String URL_MOCK_BH = 'https://viacep.com.br/ws/'+ViaCEPServiceTest.CEP_BH+'/json/';

        MockHttpResponseHandler mock = new MockHttpResponseHandler();

        //going to run this one twice...
        MockResponse oMockResponseSP = new MockResponse('GET', ViaCEPServiceTest.MOCK_SP, 200, 'OK');
        MockResponse oMockResponseRECIFE = new MockResponse('GET', ViaCEPServiceTest.MOCK_RECIFE, 200, 'OK');
        MockResponse oMockResponsePOA = new MockResponse('GET', ViaCEPServiceTest.MOCK_POA, 200, 'OK');
        MockResponse oMockResponseBH = new MockResponse('GET', ViaCEPServiceTest.MOCK_BH, 200, 'OK');

        mock.addResponse(URL_MOCK_SP, oMockResponseSP);
        mock.addResponse(URL_MOC_RECIFE, oMockResponseRECIFE);
        mock.addResponse(URL_MOCK_POA, oMockResponsePOA);
        mock.addResponse(URL_MOCK_BH, oMockResponseBH);

        Test.startTest();

            Test.setMock(HttpCalloutMock.class, mock);
        
            List<Map<String, Object>> chainList = ChainCEPCalls.run(
                ViaCEPServiceTest.CEP_SP,
                ViaCEPServiceTest.CEP_RECIFE,
                ViaCEPServiceTest.CEP_POA,
                ViaCEPServiceTest.CEP_BH
            );

        Test.stopTest();

        // SP, Recife, POA, BH
        List<String> ceps = new List<String>{'01002-020','50030-903', '90010-030', '30130-003'};

        System.debug('asserting items...');

        Integer i = 0;
        for (Map<String, Object> item : chainList) 
        {
            System.debug('------------------------------------------');
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