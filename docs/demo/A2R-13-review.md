# A2R-13 — Accès au champ du prix
Scénario : champ Case.Price__c existant mais inaccessible à un utilisateur. Permission Set de démonstration A2R_Case_Price_Editor, lecture/écriture du champ uniquement.

Un message INVALID_FIELD peut aussi indiquer un nom API incorrect : la cause FLS doit être confirmée par comparaison des métadonnées et des droits utilisateur. Aucun log réel n’est fourni. Ne pas prétendre qu’une simple absence de visibilité prouve la cause.

L’accès à l’objet et à l’enregistrement est un prérequis. Aucun droit administrateur, changement de profil ou affectation utilisateur dans cette PR. L’utilisateur et le Permission Set réellement utilisés restent à confirmer. XML non validé sur Salesforce ; aucun déploiement ni affectation.
