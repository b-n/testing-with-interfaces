@isTest
global class AccountTriggerHandlerTest {

    public static Integer calledCount = 0;

    @isTest
    public static void AccountTriggerHandlerTest() {
        //set our mock which counts how many times we hit it
        AccountSync.singleton = new AccountSyncMock(); 

        List<Account> accs = new List<Account>{
            new Account(Name = 'Testing'),
            new Account(Name = 'No I\'m Gandalf!')
        };

        insert accs;
        system.assertEquals(1, calledCount);

        accs[1].Name = 'Testing';
        update accs;
        system.assertEquals(2, calledCount);

        accs[1].Name = 'Not Testing Anymore';
        update accs;
        system.assertEquals(2, calledCount);
    }

    public class AccountSyncMock implements AccountSync.AccountSyncInterface {
        public void syncAccounts(Set<Id> accIds) {
            AccountTriggerHandlerTest.calledCount += accIds.size();
        }
    }
}
