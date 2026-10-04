# A2R-12 — Règle métier existante non respectée
Le helper initial additionnait le HT. Le correctif ajoute la TVA 5 %, arrondie par Case à 3 décimales, exclut Annulé et traite null comme 0. `accountGrandTotal` ajoute la taxe de réparation calculée sur le HT.

Exemples de recette attendus (non exécutés) : 200 → 210 TTC ; 100, 200, 300 → 630 TTC + 30 = 660. Case annulé exclu ; réouvert inclus. Aucun filtre sur le type de Case.

Hypothèses à valider : arrondi HALF_UP, taxe de réparation à 3 décimales. Le helper ne persiste aucun champ et ne comporte pas de trigger : l’appel automatique lors des changements est à intégrer. Le contrôle des avoirs RM-VAL-02 reste externe car sa règle complète n’a pas été fournie. Prix API Price__c et statut Annulé à confirmer. Code non compilé, aucun test Apex exécuté, aucun déploiement.
