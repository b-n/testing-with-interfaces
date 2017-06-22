public class AccountSync implements AccountSyncInterface {

    public interface AccountSyncInterface {
        void syncAccounts(Set<Id> accs);
    }
    
    @testVisible
    private static AccountSyncInterface singleton;
    public static AccountSyncInterface getInstance() {
        if (singleton == null) singleton = new AccountSync();
        return singleton;
    }

    @testVisible
    private AccountSync() {}

    public void syncAccounts(Set<Id> accs) {
        makeCallout(accs);
    }

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
