public with sharing class LegacyQuoteFile {
    /** 
     * @author DN
     * @date 21/10/2022
     * @description Get all legay quotes for account
     * param idRCU
    */
    @AuraEnabled
    public static ResultDataModel getLegacyQuotes(String idQuote){
        if(String.isBLank(idQuote)) throw new CustomException('idRCU Argument Undefined !'); 

        ResultDataModel result;
        HttpService myHttp = new HttpService();
        myHttp.setHeader('X-Api-Key','{!$Credential.Password}'); // I store api key in credential name
        myHttp.setHeader('Cache-Control', 'no-store');
        HttpService.Response response = myHttp.Get('api_quotelegacyfiles', '/getByIdRCU/'+idQuote);
        result = new ResultDataModel(response.Code, response.Result); 
        
        return  result;
    }

    public class ResultDataModel{
        @AuraEnabled public Integer statusCode;
        @AuraEnabled public String body;
        
        ResultDataModel(Integer statusCode, String body){
            this.statusCode = statusCode;
            this.body = body;
        }
    }
}
