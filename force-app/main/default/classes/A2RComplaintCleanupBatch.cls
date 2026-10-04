/** A2R-27 / RM-RET-01. Draft only: no scheduler and no automatic invocation.
 * Standard delete only; never emptyRecycleBin. Review API field and picklist value.
 * User-mode access applies to selection and deletion.
 */
public with sharing class A2RComplaintCleanupBatch implements Database.Batchable<SObject>, Database.Stateful {
    public Integer deletedCount = 0;
    public Integer failedCount = 0;
    public List<String> errorCodes = new List<String>();

    public Database.QueryLocator start(Database.BatchableContext context) {
        Datetime periodStart = Datetime.newInstanceGmt(2026, 1, 1, 0, 0, 0);
        Datetime periodEnd = Datetime.newInstanceGmt(2026, 7, 1, 0, 0, 0);
        String complaintType = 'Réclamation';
        return Database.getQueryLocator(
            'SELECT Id FROM Case WHERE Case_type__c = :complaintType' +
            ' AND CreatedDate >= :periodStart AND CreatedDate < :periodEnd WITH USER_MODE'
        );
    }

    public void execute(Database.BatchableContext context, List<SObject> scope) {
        Database.DeleteResult[] results = Database.delete(scope, false, AccessLevel.USER_MODE);
        for (Database.DeleteResult result : results) {
            if (result.isSuccess()) deletedCount++;
            else {
                failedCount++;
                for (Database.Error error : result.getErrors()) {
                    if (errorCodes.size() < 20) errorCodes.add(String.valueOf(error.getStatusCode()));
                }
            }
        }
    }

    public void finish(Database.BatchableContext context) {
        System.debug(LoggingLevel.INFO, 'A2R-27: deleted=' + deletedCount + ', failed=' + failedCount);
        // Human review of failures and financial recalculation is required before operational use.
    }
}
