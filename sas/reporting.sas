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
DATAFILE="/folders/myfolders/Talend_boutique.csv"
out=sas_boutique
DBMS=CSV

replace 
;
GETNAMES=YES;

run;

/*Quelle age achete le plus de livre*/
proc sql;
create table vente_client as 
select sv.id, age, tranche_age from work.SAS_CLIENT SC
full join WORK.SAS_VENTE SV
on SC.id = SV.client_id;
quit; run;

title "Quelle age achete le plus de livre";
proc sgplot data=vente_client;
	histogram age / transparency=0.7 binwidth=1;
	yaxis grid;
	xaxis display=(nolabel);
run;

/*Quelle tranche d'age achete le plus de livre*/
title "Quelle tranche d'age achete le plus de livre";
proc sgplot data=vente_client;
	vbar tranche_age / transparency=0.5 ;
run;

/*Dans quelle ville vend-on le plus en 2014*/
proc sql;
create table vente_boutique_temps_2014 as
select sv.id, tmp.annee, tmp.mois, bout.ville, bout.region from work.sas_vente sv
full join work.sas_boutique bout 
on bout.id = sv.boutique_id
full join work.sas_temps tmp
on tmp.id = sv.temps_id
where tmp.annee = 2014;
quit;run;

/*Dans quelle ville vend-on le plus en 2014*/
title "Dans quelle ville vend-on le plus en 2014";
proc sgplot data=vente_boutique_temps;
	vbar ville / transparency=0.6 ;
run;

/*Dans quelle region vend-on le plus en 2014*/
title "Dans quelle region vend-on le plus en 2014";
proc sgplot data=vente_boutique_temps;
	vbar region / transparency=0.6 ;
run;

title "nombre de ville par région";
proc sgplot data=SAS_boutique;
	vbar region / transparency=0.6 ;
run;

/*Comment sont reparties les ventes sur l'annee en region bretagne*/
proc sql;
create table vente_boutique_temps_bretagne as
select sv.id, tmp.mois from work.sas_vente sv
full join work.sas_boutique bout 
on bout.id = sv.boutique_id
full join work.sas_temps tmp
on tmp.id = sv.temps_id
where bout.region = 'Bretagne';
quit;run;

/*Comment sont reparties les ventes sur l'annee en region bretagne*/
title "Comment sont reparties les ventes sur l'annee en region bretagne";
proc sgplot data=vente_boutique_temps_bretagne ;
	vbar mois / transparency=0.6 ;
run;

/*Comment evoluent les ventes dans le temps*/
proc sql;
create table vente_temps as
select sv.id, tmp.annee from work.sas_vente sv
full join work.sas_temps tmp
on tmp.id = sv.temps_id;
quit;run;

/*Comment evoluent les ventes dans le temps*/
title "Comment evoluent les ventes dans le temps";
proc sgplot data=vente_temps ;
	vbar annee/ transparency=0.6 ;
run;