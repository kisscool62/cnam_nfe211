

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

/*Dans quelle ville fait on le plus gros 
chiffre d'affaire de livre en 2014*/
proc sql;
create table vente_boutique_temps_2014_somme as
select bout.ville, sum(sv.prix) as CA_VILLE from work.sas_vente sv
full join work.sas_boutique bout 
on bout.id = sv.boutique_id
full join work.sas_temps tmp
on tmp.id = sv.temps_id
where tmp.annee = 2014
group by ville;

quit;run;

/*Dans quelle ville fait on le plus gros 
chiffre d'affaire de livre en 2014*/
title "Dans quelle ville fait on le plus 
gros chiffre d'affaire de livre en 2014";
proc sgplot data=vente_boutique_temps_2014_somme;
	vbar ville / transparency=0.6 response=CA_VILLE; 
run;


/*Dans quelle region fait on le plus gros
 chiffre d'affaire de livre en 2014*/
proc sql;
create table vente_boutique_2014_somme_region as
select bout.region, sum(sv.prix) as CA_REGION 
from work.sas_vente sv, work.sas_boutique bout, work.sas_temps tmp 
where tmp.annee = 2014
and bout.id = sv.boutique_id
and tmp.id = sv.temps_id

group by region;

quit;run;

/*Dans quelle region fait on le plus gros 
chiffre d'affaire de livre en 2014*/
title "Dans quelle region fait on le plus gros 
chiffre d'affaire de livre en 2014";
proc sgplot data=vente_boutique_2014_somme_region;
	vbar region / transparency=0.6 response=CA_REGION; 
run;

proc print data=vente_boutique_2014_somme_region;
	var region CA_REGION;
	title "CA des regions";
run;

/*Dans quelle ville vend-on le plus de livre en 2014*/
proc sql;
create table vente_boutique_temps_2014 as
select sv.id, tmp.annee, tmp.mois, bout.ville, bout.region 
from work.sas_vente sv
full join work.sas_boutique bout 
on bout.id = sv.boutique_id
full join work.sas_temps tmp
on tmp.id = sv.temps_id
where tmp.annee = 2014;
quit;run;


/*Dans quelle ville vend-on le plus en 2014*/
title "Dans quelle ville vend-on le plus en 2014";
proc sgplot data=vente_boutique_temps_2014;
	vbar ville / transparency=0.6 ;
run;

/*Dans quelle region vend-on le plus en 2014*/
title "Dans quelle region vend-on le plus en 2014";
proc sgplot data=vente_boutique_temps_2014;
	vbar region / transparency=0.6 ;
run;

title "nombre de ville par region";
proc sgplot data=SAS_boutique;
	vbar region / transparency=0.6 ;
run;

/*Comment sont reparties les ventes 
sur l'annee en region bretagne*/
proc sql;
create table vente_boutique_temps_bretagne as
select sv.id, tmp.mois from work.sas_vente sv
full join work.sas_boutique bout 
on bout.id = sv.boutique_id
full join work.sas_temps tmp
on tmp.id = sv.temps_id
where bout.region = 'Bretagne';
quit;run;

/*Comment sont reparties les ventes 
sur l'annee en region bretagne*/
title "Comment sont reparties les ventes 
sur l'annee en region bretagne";
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

/*Comment sont repartis les achats de livres*/
proc sql;
create table vente_livre as
select sas_vente.id, nom, genre 
from sas_vente
inner join sas_livre
on sas_livre.id = sas_vente.livre_id;
quit;run;

/*Comment sont repartis les achats de livres*/
title "Comment sont repartis les achats de livres";
proc sgplot data=vente_livre;
	vbar nom / transparency=0.6;
run;

/*Comment sont repartis les achats de livres*/
proc sql;
create table vente_livre_somme as
select nom, sum(prix) as CA_LIVRE 
from sas_vente
inner join sas_livre
on sas_livre.id = sas_vente.livre_id
group by nom;
quit;run;

/*Comment sont repartis les achats de livres*/
title "Comment sont repartis les achats de livres";
proc sgplot data=vente_livre_somme;
	vbar nom / transparency=0.2 response=CA_LIVRE;
run;


/*Comment sont repartis les achats de livres*/
title "Comment sont repartis les achats de livres";
proc sgplot data=vente_livre;
	vbar genre/ transparency=0.6;
run;

/*Comment sont repartis les achats de livres par genre*/
proc sql;
create table vente_livre_somme_genre as
select genre, sum(prix) as CA_LIVRE 
from sas_vente
inner join sas_livre
on sas_livre.id = sas_vente.livre_id
group by genre;
quit;run;

/*Comment sont repartis les achats de livres par genre*/
title "Comment sont repartis les achats de livres par genre";
proc sgplot data=vente_livre_somme_genre;
	vbar genre / transparency=0.2 response=CA_LIVRE;
run;

/*Comment sont repartis les achats 
de livres par genre et par annee*/
proc sql;
create table vente_livre_annee_genre as
select annee, genre, sum(prix) as CA_LIVRE 
from sas_vente
inner join sas_livre
on sas_livre.id = sas_vente.livre_id
inner join sas_temps
on sas_vente.temps_id = sas_temps.id
group by annee, genre;
quit;run;

/*Comment sont repartis les achats 
de livres par genre et par annee*/
title "Comment sont repartis les achats 
de livres par genre et par annee";
proc sgplot data=vente_livre_annee_genre ;
	vbar annee 
	/ transparency=0.2 
	group=genre groupdisplay=cluster response=CA_LIVRE;
run;