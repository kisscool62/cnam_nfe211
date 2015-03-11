data WORK.SAS_CLIENT    ;
 %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
 infile '/folders/myfolders/Talend_client.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 encoding='wlatin1';
 	informat id best32. ;
 	informat prenom $9. ;
 	informat age best32. ;
 	informat tranche_age $5. ;
 	format id best32. ;
 	format prenom $9. ;
 	format age best32. ;
 	format tranche_age $5. ;
 input
 	id
 	prenom $
 	age
 	tranche_age $
 	;
 	if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
 run;
 
PROC IMPORT
DATAFILE="/folders/myfolders/Talend_vente.csv"
out=sas_vente
DBMS=CSV

replace 
;
GETNAMES=YES;

run;

PROC IMPORT
DATAFILE="/folders/myfolders/Talend_temps.csv"
out=sas_temps
DBMS=CSV

replace 
;
GETNAMES=YES;

run;

PROC IMPORT
DATAFILE="/folders/myfolders/Talend_livre.csv"
out=sas_livre
DBMS=CSV

replace 
;
GETNAMES=YES;

run;

data WORK.SAS_BOUTIQUE    ;
 %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
 infile '/folders/myfolders/Talend_boutique.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 encoding='wlatin1';
 informat id best32. ;
 informat nom $29. ;
 informat adresse $28. ;
 informat ville $13. ;
 informat departement $14. ;
 informat region $15. ;
 format id best12. ;
 format nom $29. ;
 format adresse $28. ;
 format ville $13. ;
 format departement $14. ;
 format region $15. ;
 input
 id
 nom $
 adresse $
 ville $
 departement $
 region $
 ;
 if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
 run;