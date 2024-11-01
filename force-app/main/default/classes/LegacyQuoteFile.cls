public with sharing class LegacyQuoteFile extends HttpService {
    /** 
     * @author 
     * @date XX/XX/XXX
     * @description 
     * param idQuote
    */
    @AuraEnabled
    public static HttpService.Response getLegacyQuotes(String idQuote){
        if(String.isBLank(idQuote)) throw new CustomException('idQuote Argument Undefined !'); 

        String getSuffixeMethod = 'from custom metadata';//Best practice
        this.setHeader('X-Api-Key','{!$Credential.Password}');
        this.setHeader('Cache-Control', 'no-store');
        HttpService.Response response = this.doGet('credential_name', '/'+getSuffixeMethod+'/'+idQuote);
        
        return  response;
    }

    /** 
     * @author 
     * @date XX/XX/XXX
     * @description 
     * param idQuote
    */
    @AuraEnabled
    public static HttpService.Response createLegacyQuote(String name, String idQuote){

        String getSuffixeMethod = 'from custom metadata';
        this.setHeader('X-Api-Key','{!$Credential.Password}');
        HttpService.Response response = this.doPost('credential_name', 
                                                    '/'+getSuffixeMethod,
                                                    new QuoteWrapper(name, idQuote));
        
        return  response;
    }

    public class QuoteWrapper{
        public String name { get; set; }
        public String idQuote { get; set; }
        public QuoteWrapper(string name, string idQuote){
            this.name = name;
            this.idQuote = idQuote;
        }
    }
}
