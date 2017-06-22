@isTest
global class AccountSyncTest {

    public static Integer calloutCount = 0;

    @isTest
    public static void AccountTriggerHandlerTest() {
        Test.setMock(HttpCalloutMock.class, new AccountSyncMock());
        List<Account> accs = new List<Account>{
            new Account(Name = 'Testing'),
            new Account(Name = 'No I\'m Gandalf!')
        };

        Test.startTest();
        insert accs;
        Test.stopTest();

        system.assertEquals(1, calloutCount);
    }

    global class AccountSyncMock implements HttpCalloutMock {
        global HttpResponse respond(HttpRequest req) {
            AccountSyncTest.calloutCount++;

            HttpResponse res = new HttpResponse();
            res.setBody(req.getBody());
            res.setStatusCode(200);
            return res;
        }
    }
}
