trigger AccountTrigger on Account (after insert, after update) {
    
    Set<Id> syncAccounts = new Set<Id>();

    if (Trigger.isAfter) {
        for (Account a : Trigger.new) {
            if (a.Name == 'Testing') {
                if (Trigger.isInsert ||
                        (Trigger.isUpdate && Trigger.oldMap.get(a.Id).Name != a.Name)) {
                    syncAccounts.add(a.Id);       
                }
            }
        }
    }

    if (!syncAccounts.isEmpty()) AccountSync.makeCallout(Trigger.newMap.keyset());
}