public class AccountSync {

    @future (callout=true)
    public static void makeCallout(Set<Id> accIds) {
        List<Account> accs = [ select Id, Name, ShippingAddress
                               from   Account
                               where  Id in :accIds ];
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://localhost/');
        req.setMethod('POST');
        req.setBody(JSON.serialize(accs));
        
        new Http().send(req);
    }
}
