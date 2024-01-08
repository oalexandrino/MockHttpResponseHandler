/**
 * @description Interface used for MockReponses. 
 * @author Olavo Alexandrino <oalexandrino@gmail.com>
 * @param  HTTPRequest req 
 * @return String
 */
public interface IMockResponse{
    HTTPResponse getResponse(HTTPRequest req);
    String getMethod();
    void checkRequestProperties();
}