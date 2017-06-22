@isTest
global class AccountSyncTest {

    public static Integer calloutCount = 0;

    @testSetup
    public static void testSetup() {
        //mock the singleton, we don't want the trigger calling out code
        AccountSync.singleton = new AccountSyncMock();

        //insert test data
        List<Account> accs = new List<Account>{
            new Account(Name = 'Testing'),
            new Account(Name = 'No I\'m Gandalf!')
        };
        insert accs;
    }

    @isTest
    public static void syncAccounts() {
        Test.setMock(HttpCalloutMock.class, new AccountSyncWSMock());
        Set<Id> accIds = (new Map<Id, Account>([ select Id from Account ])).keyset();

        system.assertEquals(0, calloutCount);
        Test.startTest();
        AccountSync syncer = new AccountSync();
        syncer.syncAccounts(accIds);
        Test.stopTest();

        system.assertEquals(1, calloutCount);
    }

    global class AccountSyncWSMock implements HttpCalloutMock {
        global HttpResponse respond(HttpRequest req) {
            AccountSyncTest.calloutCount++;

            HttpResponse res = new HttpResponse();
            res.setBody(req.getBody());
            res.setStatusCode(200);
            return res;
        }
    }

    public class AccountSyncMock implements AccountSync.AccountSyncInterface {
        public void syncAccounts(Set<Id> accs) {}
    }
}
