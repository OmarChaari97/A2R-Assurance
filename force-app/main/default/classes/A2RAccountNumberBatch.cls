public inherited sharing class A2RAccountNumberBatch implements Database.Batchable<SObject>, Schedulable {

    private Integer updatedCount = 0;
    private Integer errorCount = 0;

    // ---------- Batchable ----------

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id, AccountNumber
            FROM Account
        ]);
    }

    public void execute(Database.BatchableContext bc, List<SObject> scope) {
        List<Id> accountIds = new List<Id>();
        for (SObject sobj : scope) {
            accountIds.add(sobj.Id);
        }

        // Re-query and lock rows to handle concurrent updates
        List<Account> accounts = [
            SELECT Id, AccountNumber
            FROM Account
            WHERE Id IN :accountIds
            FOR UPDATE
        ];

        List<Account> accountsToUpdate = new List<Account>();
        for (Account acc : accounts) {
            if (String.isBlank(acc.AccountNumber)) {
                acc.AccountNumber = 'ACC-' + acc.Id;
                accountsToUpdate.add(acc);
            }
        }

        if (!accountsToUpdate.isEmpty()) {
            Database.SaveResult[] results = Database.update(accountsToUpdate, false);
            for (Database.SaveResult result : results) {
                if (result.isSuccess()) {
                    updatedCount++;
                } else {
                    errorCount++;
                    for (Database.Error err : result.getErrors()) {
                        System.debug(LoggingLevel.ERROR, 'A2RAccountNumberBatch error: ' + err.getStatusCode());
                    }
                }
            }
        }
    }

    public void finish(Database.BatchableContext bc) {
        System.debug(LoggingLevel.INFO, 'A2RAccountNumberBatch complete. Updated: ' + updatedCount + ', Errors: ' + errorCount);
    }

    // ---------- Schedulable ----------

    public void execute(SchedulableContext sc) {
        Database.executeBatch(new A2RAccountNumberBatch(), 200);
    }

    // ---------- Scheduling helper ----------

    public static String scheduleDaily() {
        List<CronTrigger> existing = [
            SELECT Id
            FROM CronTrigger
            WHERE CronJobDetail.Name = 'A2RAccountNumberBatch'
            AND CronJobDetail.JobType = '7'
        ];
        if (!existing.isEmpty()) {
            return 'A2RAccountNumberBatch already scheduled.';
        }
        return System.schedule('A2RAccountNumberBatch', '0 0 2 * * ?', new A2RAccountNumberBatch());
    }
}