public class ViaCEPService {

    public static final String VIACEP_URL = 'https://viacep.com.br/ws/{CEP}/json/';

    public static HttpResponse query(String cep) {

        cep = cep.replaceAll('[^0-9]', '');
        String url = VIACEP_URL.replace('{CEP}', cep);
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        Http http = new Http();
        HttpResponse res = http.send(req);

        return res;
    }

    public static Map<String, Object> format(HttpResponse res)
    {
        Map<String, Object> objResult;

        if (res.getStatusCode() == 200) {
            objResult = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        } else {
            objResult.put('Message', res.getBody());
        }

        objResult.put('StatusCode', res.getStatusCode());
        objResult.put('Status', res.getStatus());        

        return objResult;
    }
}