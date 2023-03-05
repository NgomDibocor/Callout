public with sharing class LegacyQuoteFile {
    /** 
     * @author 
     * @date XX/XX/XXX
     * @description 
     * param idQuote
    */
    @AuraEnabled
    public static HttpService.Response getLegacyQuotes(String idQuote){
        if(String.isBLank(idQuote)) throw new CustomException('idQuote Argument Undefined !'); 

        HttpService myHttp = new HttpService();
        myHttp.setHeader('X-Api-Key','{!$Credential.Password}'); // I store api key in credential name
        myHttp.setHeader('Cache-Control', 'no-store');
        HttpService.Response response = myHttp.Get('credential_name', '/getFileByIdQuote/'+idQuote);
        
        return  response;
    }
}
