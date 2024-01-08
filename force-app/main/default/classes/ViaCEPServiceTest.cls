
/**
 * @author Olavo Alexandrino <oalexandrino@gmail.com>
 */
@isTest
public class ViaCEPServiceTest {

    public static final String MOCK_SP = '{"cep": "01002-020","logradouro": "Viaduto do Chá", "complemento": "", "bairro": "Centro", "localidade": "São Paulo", "uf": "SP"}';
    public static final String MOCK_RECIFE = '{"cep": "50030-903","logradouro": "Cais do Apolo", "complemento": "925", "bairro": "Centro", "localidade": "Recife", "uf": "PE"}';
    public static final String MOCK_POA = '{"cep": "90010-030","logradouro": "Rua General João Manoel", "complemento": "925", "bairro": "Centro Histórico", "localidade": "Porto Alegre", "uf": "RS"}';
    public static final String MOCK_BH = '{"cep": "30130-003","logradouro": "Avenida Afonso Pena", "complemento": "de 656 a 1350 - lado par", "bairro": "Centro", "localidade": "Belo Horizonte", "uf": "MG"}';

    public static final String CEP_SP = '01002020';
    public static final String CEP_RECIFE = '50030903';
    public static final String CEP_POA = '90010030';    
    public static final String CEP_BH = '30130003';    

    @isTest
    static void testQueryOKOnly1Call() 
    {
        Test.startTest();

            Test.setMock(HttpCalloutMock.class, new ViaCEPMock(MOCK_SP, 'OK', 200));
            HttpResponse res = ViaCEPService.query('01002-020');
            Map<String, Object> result = ViaCEPService.format(res);

        Test.stopTest();

        Map<String, Object> objExpectedResult = (Map<String, Object>) JSON.deserializeUntyped(MOCK_SP);

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


    /**
     * Default Mock for ViaCEPService
     * @author Olavo Alexandrino <oalexandrino@gmail.com>
     */
    public class ViaCEPMock implements HttpCalloutMock {

        private String body;
        private String status;
        private Integer statusCode;

        public ViaCEPMock(String body, String status, Integer statusCode)
        {
            this.body = body;
            this.status = status;
            this.statusCode = statusCode;
        }

        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatus(this.status);
            res.setStatusCode(this.statusCode);
            res.setBody(this.body);
            return res;
        }
    }
}