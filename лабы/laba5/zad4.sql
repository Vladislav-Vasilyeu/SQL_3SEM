SELECT 
    (SELECT AVG(NOTE) 
     FROM PROGRESS 
     WHERE SUBJECT = '����') AS AVG_OAiP,
    (SELECT AVG(NOTE) 
     FROM PROGRESS 
     WHERE SUBJECT = '��') AS AVG_BD,
    (SELECT AVG(NOTE) 
     FROM PROGRESS 
     WHERE SUBJECT = '����') AS AVG_SUBD;
