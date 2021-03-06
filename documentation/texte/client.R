library(dplyr)
library(tidyr)

setwd('E:/workspace/R/cnam/nfe211')

prenoms <- read.csv('liste_des_prenoms_par_annee.csv', sep = ';')


head(prenoms)
hist(prenoms$nombre)
summary(prenoms$nombre)
hist(x = prenoms$annee)
nb_clients <- length(prenoms$prenoms)


X <- 10 + rnorm(nb_clients, mean=5, sd = 1)
Y <- 5 + rnorm(nb_clients, mean=20, sd = 2)

U <- rbinom(n=nb_clients, size=1, prob=0.6)
summary(U)


hist(X)


hist(Y)
Z <- U * X + ((U-1)*-1 + Y)
hist(Z)
age <- floor(Z)
clients <- cbind(prenoms, age)
head(clients)
hist(clients$age)


type<-floor(1+rnorm(nb_clients, mean=1.4, sd=0.6)%%3)
hist(type)
clients <- cbind(clients, type)

livres <- c(6, 7, 1, 2, 4, 8, 3, 5)

# distribution sur livres
livres_achetes <- floor(rnorm(nb_clients, mean = 3.5, sd=1.5))
livres_achetes <- sapply(livres_achetes, FUN = function(x) max(0,x))
livres_achetes <- sapply(livres_achetes, FUN = function(x) min(7,x))
hist(livres_achetes)


clients <- cbind(clients, livres_achetes)
head(clients)

# lien vers la table livre
livre <- sapply(livres_achetes, FUN=function(x)livres[x+1])
clients <- cbind(clients, livre)


hist(clients$livre)

boutiques <- floor(runif(nb_clients, min=1, max=25))
clients <- cbind(clients, boutiques)
hist(boutiques)

client_id <- 1:length(clients$prenoms)

clients <- cbind(clients, client_id)

#last date in the data
end_date <- as.Date('2015-01-01')

date_achat <- end_date - runif(n=nb_clients, max=365*5, min=1)


clients <- cbind(clients, date_achat)
clients <- mutate(clients, prenom = prenoms)

clients_for_csv <- select(clients, id=client_id, age, prenom)
write.csv(x=clients_for_csv, file='clients.csv', row.names=FALSE)
nb_clients + 1 - client_id

clients <- mutate(clients, facture_id = (nb_clients + 1 - client_id))

facture_for_csv <- select(clients, id=facture_id, date_achat, boutique_id=boutiques, client_id=client_id, livre_id=livre)
write.csv(x=facture_for_csv, file='factures.csv', row.names=FALSE)

villes <- read.csv(file='ville.csv')
departements <- read.csv('departement.csv')
regions <- read.csv('region.csv')
