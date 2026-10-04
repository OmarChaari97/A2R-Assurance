/** A2R-12: RM-FIN-01 to RM-FIN-06 financial calculation helper.
 * Pure calculation only. Caller supplies all Cases for one Account and persists results.
 * Negative-price eligibility (RM-VAL-02) is enforced by the calling validation layer.
 */
public inherited sharing class A2RCaseFinancialHelper {
    private static final Decimal RATE = 0.05;

    public static Decimal sumCasePrices(List<Case> cases) {
        Decimal total = 0;
        for (Case item : cases) {
            if (item.Status == 'Annulé') continue;
            Decimal price = (Decimal)item.get('Price__c');
            price = price == null ? 0 : price;
            Decimal vat = (price * RATE).setScale(3, RoundingMode.HALF_UP);
            total += price + vat;
        }
        return total;
    }

    public static Decimal repairTax(List<Case> cases) {
        Decimal totalExclVat = 0;
        for (Case item : cases) {
            if (item.Status == 'Annulé') continue;
            Decimal price = (Decimal)item.get('Price__c');
            totalExclVat += price == null ? 0 : price;
        }
        return (totalExclVat * RATE).setScale(3, RoundingMode.HALF_UP);
    }

    public static Decimal accountGrandTotal(List<Case> cases) {
        return sumCasePrices(cases) + repairTax(cases);
    }
}
