# RM-RET-01 — Nouvelle règle métier proposée

Ticket : A2R-27. État : à faire approuver et indexer dans la base de connaissances.

- Objet : Case ; type : `Case_type__c = Réclamation` (nom API et valeur à confirmer dans les métadonnées réelles).
- Période de création : du 1er janvier 2026 à 00:00 UTC inclus au 1er juillet 2026 à 00:00 UTC exclu.
- Action : suppression standard récupérable, sans purge définitive, afin de libérer de l’espace. La capacité récupérée doit être mesurée ; aucune garantie chiffrée.
- Aucune restriction de statut demandée ; tous les statuts sont dans le périmètre proposé.
- Aucun batch lancé ni planifié. Aucun déploiement effectué.
- Avant exploitation : vérifier conservation réglementaire, export, droits, dépendances et recalcul des totaux de compte (RM-FIN-02/03).
- Comptabiliser les suppressions réussies et les erreurs partielles.

## Base de connaissances de l’agent
Après approbation métier, ajouter cette nouvelle règle et ses bornes temporelles au référentiel. La PR contient la proposition documentaire ; elle ne réalise aucune indexation RAG.
