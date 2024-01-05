public with sharing class ChainCEPCalls 
{
    /**
     * Executes a chain of CEP calls.
     * 
     * @param cep1 The first CEP to be called.
     * @param cep2 The second CEP to be called.
     * @param cep3 The third CEP to be called.
     * @return A list of maps containing the response data from each CEP call.
     */
    public static List<Map<String, Object>> run(String cep1, String cep2, String cep3) {

        List<Map<String, Object>> addresses = new List<Map<String, Object>>();
        HttpResponse res = ViaCEPService.query(cep1);
        
        if (res.getStatusCode() == 200) {
            
            Map<String, Object> addr = ViaCEPService.format(res);
            addresses.add(addr);

            HttpResponse res2 = ViaCEPService.query(cep2);
            
            if (res2.getStatusCode() == 200) {
            
                Map<String, Object> addr2 = ViaCEPService.format(res2);
                addresses.add(addr2);
                HttpResponse res3 = ViaCEPService.query(cep3);

                if (res3.getStatusCode() == 200) {
            
                    Map<String, Object> addr3 = ViaCEPService.format(res3);
                    addresses.add(addr3);
                }
            }
        }

        return addresses;
    }
}