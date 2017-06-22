public class AccountTriggerHandler {

    private List<Account> newAccountList;
    private Map<Id, Account> oldAccountMap;

    public AccountTriggerHandler() {
        this.newAccountList = Trigger.new;
        this.oldAccountMap = (Map<Id, Account>)Trigger.oldMap;
    }

    public void afterInsert() {
        Set<Id> accIds = new Set<Id>();

        for (Account a : newAccountList) {
            if (a.Name == 'Testing') {
                accIds.add(a.Id);
            }
        }

        if (!accIds.isEmpty()) AccountSync.getInstance().syncAccounts(accIds);
    }
    
    public void afterUpdate() {
        Set<Id> accIds = new Set<Id>();

        for (Account a : newAccountList) {
            if (a.Name == 'Testing' && oldAccountMap.get(a.Id).Name != a.Name) {
                accIds.add(a.Id);
            }
        }

        if (!accIds.isEmpty()) AccountSync.getInstance().syncAccounts(accIds);
    }
}
