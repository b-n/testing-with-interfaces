@isTest
global class AccountTriggerHandlerTest {

    @isTest
    public static void AccountTriggerHandlerTest() {
        //we need the line below other we'll get errors
        //  even though it doesn't have anything to do with testing this stuff
        Test.setMock(HttpCalloutMock.class, new AccountSyncTest.AccountSyncMock());

        List<Account> accs = new List<Account>{
            new Account(Name = 'Testing'),
            new Account(Name = 'No I\'m Gandalf!')
        };

        insert accs;

        accs[1].Name = 'Testing';
        update accs;
    }
}
