/**
 * @description Interface used for MockReponses. Implement this if you need a specialized Mock Response
 * @author Olavo Alexandrino <olavo.barbosa@vr.com.br>
 * @param  HTTPRequest req 
 * @return String
 */
public interface IMockResponse{
    HTTPResponse getResponse(HTTPRequest req);
    String getMethod();
}