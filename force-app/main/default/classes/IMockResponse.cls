/**
 * @description Interface used for MockReponses. 
 * @author Olavo Alexandrino <oalexandrino@gmail.com>
 */
public interface IMockResponse{

    /**
     * @description Each concrete class can have its own approach to process the request, so implement this method
     */
    HTTPResponse getResponse(HTTPRequest req);
    
    /**
     * @description Interfaces cannot access classes members in polymorphic calls, so we need to access it by ensuring that the class implements the interface.
     */    
    String getMethod();

    /**
     * @description Each concrete class can have its own approach to check response properties
     */
    void checkRequestProperties();
}