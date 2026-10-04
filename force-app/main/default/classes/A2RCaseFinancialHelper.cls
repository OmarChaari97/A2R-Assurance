/** Demonstration baseline: intentionally reproduces A2R-12. Not for deployment. */
public inherited sharing class A2RCaseFinancialHelper {
    public static Decimal sumCasePrices(List<Case> cases) {
        Decimal total = 0;
        for (Case item : cases) {
            if (item.Status == 'Annulé') continue;
            Decimal price = (Decimal)item.get('Price__c');
            total += price == null ? 0 : price;
        }
        return total;
    }
}
