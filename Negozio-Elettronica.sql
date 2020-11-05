############################################################################
################      Script per progetto BDSI 2019/20     #################
############################################################################
#									   
# GRUPPO FORMATO DA:							   
#									   
# Matricola:      Cognome:  	    Nome:      
# Matricola:      Cognome:          Nome:             
# Matricola:      Cognome: 	    Nome:             
#									   
############################################################################




############################################################################
################   Creazione schema e vincoli database     #################
############################################################################

DROP DATABASE IF EXISTS NEGOZIO_ELETTRONICA;
CREATE DATABASE IF NOT EXISTS NEGOZIO_ELETTRONICA;
USE NEGOZIO_ELETTRONICA;

DROP TABLE IF EXISTS Clienti;

CREATE TABLE IF NOT EXISTS Clienti (
    CodiceCliente INT AUTO_INCREMENT,
    TesseraFedelta TINYINT DEFAULT 0,
    Nome VARCHAR(15) NOT NULL,
    Cognome VARCHAR(15) NOT NULL,
    PuntiAcquisto INT,
    Telefono VARCHAR(15),
    Citta VARCHAR(20),
    PRIMARY KEY (CodiceCliente)
)  ENGINE=INNODB;

DROP TABLE IF EXISTS PuntiVendita;

CREATE TABLE IF NOT EXISTS PuntiVendita (
    IdPuntoVendita INT AUTO_INCREMENT,
    Citta VARCHAR(20) NOT NULL,
    Telefono VARCHAR(15),
    Email VARCHAR(40),
    Via VARCHAR(15),
    NumeroCivico INT,
    PRIMARY KEY (IdPuntoVendita)
)  ENGINE=INNODB;

DROP TABLE IF EXISTS Dipendenti;

CREATE TABLE IF NOT EXISTS Dipendenti (
    CodiceDipendente INT AUTO_INCREMENT,
    Nome VARCHAR(15) NOT NULL,
    Cognome VARCHAR(15) NOT NULL,
    Reparto VARCHAR(15) NOT NULL,
    CDF VARCHAR(16) NOT NULL,
    Email VARCHAR(25),
    Telefono VARCHAR(15),
    IdPuntoVendita INT NOT NULL,
    PRIMARY KEY (CodiceDipendente),
    FOREIGN KEY (IdPuntoVendita)
        REFERENCES PuntiVendita (IdPuntoVendita)
        ON UPDATE CASCADE
)  ENGINE=INNODB;

DROP TABLE IF EXISTS CarrelliClienti;

CREATE TABLE IF NOT EXISTS CarrelliClienti (
    IdCarrello INT,
    CodiceCliente INT NOT NULL,
    CodiceDipendente INT NOT NULL,
    data DATE,
    PRIMARY KEY (IdCarrello),
    FOREIGN KEY (CodiceCliente)
        REFERENCES Clienti (CodiceCliente)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (CodiceDipendente)
        REFERENCES Dipendenti (CodiceDipendente)
        ON UPDATE CASCADE 
)  ENGINE=INNODB;

DROP TABLE IF EXISTS Prodotti;

CREATE TABLE IF NOT EXISTS Prodotti (
    CodiceProdotto VARCHAR(25),
    PrezzoUnitario INT NOT NULL,
    Descrizione VARCHAR(100),
    Categoria VARCHAR(30) NOT NULL,
    Giacenza INT NOT NULL,
    PRIMARY KEY (CodiceProdotto)
)  ENGINE=INNODB; 

DROP TABLE IF EXISTS DettagliCarrelloClienti;


CREATE TABLE IF NOT EXISTS DettagliCarrelloClienti (
    CodiceProdotto VARCHAR(25),
    IdCarrello INT,
    QuantitaOrdinata INT,
    PRIMARY KEY (CodiceProdotto , IdCarrello),
    FOREIGN KEY (IdCarrello)
        REFERENCES CarrelliClienti (IdCarrello)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (CodiceProdotto)
        REFERENCES Prodotti (CodiceProdotto)
        ON UPDATE CASCADE
)  ENGINE=INNODB;


DROP TABLE IF EXISTS FattureAzienda;

CREATE TABLE IF NOT EXISTS FattureAzienda (
    CodiceProdotto VARCHAR(25),
    NumeroOrdine INT,
    PrezzoTotale INT,
    QuantitaOrdinata INT NOT NULL,
    PRIMARY KEY (CodiceProdotto , NumeroOrdine)
)  ENGINE=INNODB;


DROP TABLE IF EXISTS FornitoriAzienda;

CREATE TABLE IF NOT EXISTS FornitoriAzienda (
    PartitaIva VARCHAR(11),
    NomeAzienda VARCHAR(15) NOT NULL,
    CapitaleDiDebito INT,
    Email VARCHAR(50),
    Telefono VARCHAR(15),
    PRIMARY KEY (PartitaIva)
)  ENGINE=INNODB;


DROP TABLE IF EXISTS OrdineMerceAzienda;

CREATE TABLE IF NOT EXISTS OrdineMerceAzienda (
    NumeroOrdine INT,
    CodiceDipendente INT NOT NULL,
    IdFornitore VARCHAR(11) NOT NULL,
    Data DATE,
    PRIMARY KEY (NumeroOrdine),
    FOREIGN KEY (IdFornitore)
        REFERENCES FornitoriAzienda (PartitaIva)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (CodiceDipendente)
        REFERENCES Dipendenti (CodiceDipendente)
        ON UPDATE CASCADE
)  ENGINE=INNODB;



############################################################################
################  Creazione istanza: popolamento database  #################
############################################################################


INSERT INTO Clienti (TesseraFedelta, Nome,Cognome,PuntiAcquisto,Telefono,Citta) VALUES 
		(1,'Ippolito','Trevisan',7000,'03604046459','Torrenova'),
                (0,'Neera','Manfrin',1500,'03495836467','Vattaro'),
                (1,'Elisa','Pagnotto',500,'03215244220','Torrenova'),
                (0,'Lis','Partoni',1500,'0324484220','Catanzaro'),
                (1,'Francesco','Maida',3260,'3989700214','Catanzaro'),
                (0,'Antonio','Lentini',6100,'3661893144','Firenze'),
                (1,'Giuseppe','Antonino',5000,'3989700214','Busto Arstizio');

INSERT into PuntiVendita (Citta,Telefono,Email,Via,NumeroCivico) values
		("Torrenova", "3987175699", "EleccTorrenova@imp.org", "Castelletto", 59),
		("Firenze", "3987352901", "ElecFirenze@imp.org", "Pisacane", 81),
		("Vattaro", "3337651680", "EleccVattaro@imp.org", "Pandone", 21),
		("Catanzaro", "3988853721", "ElecCatanzaro@imp.org", "Cassiodoro", 9);

INSERT INTO Dipendenti(Nome,Cognome,Reparto,CDF,Email,Telefono,IdPuntoVendita)   VALUES 
		('Facino','Trentino','Informatica','QP49984861','trts129@gmail.com','3928172812',1),
		('Catone','Lombardi','Multimedia','EF89401188','ctlombrd@gmail.com','3810283618',1),
		('Cristina','Costa','Casalinghi','UJ13516992','crstcst@gmail.com','3718927381',1),
		('Alice','Milani','Informatica','ZC31322934','alclmn@pec.org','3891829312',2),
		('Simona','Romani','Multimedia','BP91311306','smnrmn@gmail.com','2781738127',2),
		('Cesio','Romani','Casalinghi','AP43923843','csromani96@gmail.com','2691828312',2),
		('Fiore','Boni','Informatica','CR94222870','bonifiori@pec.it','3921902812',3),
		('Leonide','Castiglione','Multimedia','PJ73063215','leonidecast@gmail.com','3917263192',3),
		('Flavio','Lucciano','Casalinghi','DA17173417','lucciano85@pec.com','3977013192',3),
		('Enrico','Zighi','Informatica','ENRZGH99P05A333B','zighienrico@pec.com','0779182711',1);
        

INSERT INTO CarrelliClienti VALUES 
		(20,6,3,'2016-09-17'),
		(72,6,10,'2020-04-30'),
		(78,5,4,'2017-07-01'),
		(90,2,2,'2019-06-06'),
		(111,5,2,'2020-04-04'),
		(152,2,3,'2019-09-20'),
		(654,7,3,'2019-08-01'),
		(999,7,9,'2016-09-08'),
        	(290,4,7,NULL);

INSERT INTO Prodotti VALUES 
		('0L8172Q312',400,'Televisione','Multimedia',12),
		('8PLAZXC3UL',100,'Fotocamera digitale','Multimedia',20),
		('AX81729312',238,'Tastiera per pc','Informatica',25),
		('CD10387219',18,'Mouse per pc','Informatica',90),
		('MP01AJKSHQ',90,'Tablet','Informatica',80),
		('PL9I819213',28,'Ferro Da Stiro','Casalinghi',20);


/*
SET GLOBAL local_infile = on;
SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

load data local infile 'DettagliCarrelloClienti.txt' #dettaglicarrelloclienti.txt aggiornato a: https://ghostbin.co/paste/syano
into table DettagliCarrelloClienti
fields terminated by ','
lines terminated by '\n'
ignore 3 lines;
*/

INSERT INTO DettagliCarrelloClienti VALUES 
		('0L8172Q312',90,1),
		('0L8172Q312',152,1),
		('0L8172Q312',999,1),
		('8PLAZXC3UL',72,3),
		('8PLAZXC3UL',90,2),
		('8PLAZXC3UL',111,2),
		('AX81729312',20,2),
		('CD10387219',20,1),
		('MP01AJKSHQ',78,1),
		('MP01AJKSHQ',90,10),
		('MP01AJKSHQ',999,1),
		('PL9I819213',90,1);


INSERT INTO FattureAzienda VALUES 
		('0L8172Q312',1,NULL,5),
		('0L8172Q312',817,NULL,11),
		('8PLAZXC3UL',188,NULL,4),
		('AX81729312',809,NULL,18),
		('CD10387219',771,NULL,15),
		('CD10387219',1001,NULL,21),
		('MP01AJKSHQ',209,NULL,10),
		('PL9I819213',817,NULL,9);

INSERT INTO FornitoriAzienda(PartitaIva,NomeAzienda,CapitaleDiDebito,Email,Telefono)  VALUES 
		('20153418538','SAMSUNG S.R.L',13000,'impresa@samsung.org','3901827381'),
		('20253588538','AntComputer',20000,'inform.ant@gmail.com','3689547'),
		('30953357185','Apple',25000,'apple@apple.com','3911027481'),
		('33882015386','Tethra',152077,'Thetraforum@info.org','3689547'),
		('41153300000','DELL',12000,'dellcomputers@dell.com','3901921381'),
		('41853247185','HP',19000,'hp@hpcomputers.com','3901921381'),
		('55892462809','ASUS S.R.L',150000,'asusinfo@asus.com','3201921081'),
		('73927348472','UseHome',71100,'UseHomeservice@jourrapide.com','368954019'),
		('90951588538','CyMacro',390001,'inform.ant@gmail.com','3691289547');

INSERT INTO OrdineMerceAzienda VALUES 
	(1,6,'20153418538','2018-12-29'),
	(188,10,'20253588538','2020-03-19'),
	(209,4,'20253588538','2019-03-10'),
	(771,1,'30953357185','2019-02-02'),
	(809,4,'41853247185','2019-03-20'),
	(817,7,'55892462809','2017-10-16'),
	(1001,9,'90951588538','2019-05-01');



#############################################################################
################  Ulteriori vncoli tramite viste e/o trigger ################
#############################################################################

##Vista per esercizio 18 sulle Interrogazioni leggere lì la traccia
CREATE VIEW TotaleProdottiVendutiDaiDipendenti AS
    (SELECT 
        D.Nome,
        D.Cognome,
        COUNT(C.CodiceDipendente) AS TotaleOrdiniGestiti
    FROM
        CarrelliClienti C
            NATURAL JOIN
        Dipendenti D
    GROUP BY C.CodiceDipendente);

#1)creare una vista AventiDirittoSconto: se il cliente ha la tessera della fedelta e ha dei punti acquisto > 5000
#allora ha diritto allo sconto del 50% sul prossimo acquisto se invece ha speso una cifra compresa tra i 3000 e 5000 
#allora ha diritto al 25% di sconto sul prossimo acquisto. 10 % per gli inferiori ai 3000 punti

#tinyint è boolean con 0 e 1 select * from clienti where tesserafedelta is true;

	create view AventiDirittoSconto(Nome,Cognome,PercentualeSconto) AS 
	(
		SELECT  Nome,Cognome,50 FROM Clienti WHERE TesseraFedelta IS TRUE AND PuntiAcquisto > 5000
		UNION
		SELECT  Nome,Cognome,25 FROM Clienti WHERE TesseraFedelta IS TRUE AND PuntiAcquisto BETWEEN 3000 AND 5000
		UNION
		SELECT  Nome,Cognome,10 FROM Clienti WHERE TesseraFedelta IS TRUE AND PuntiAcquisto < 3000
	);

#2) Creare una trigger che per qualsiasi acquisto da un fornitore modifichi la giacenza del prodotto ordinato in base alla fattura

	DROP TRIGGER IF EXISTS UpdateStocks;

	DELIMITER $$

	CREATE TRIGGER UpdateStocks 
	AFTER INSERT ON FattureAzienda
	FOR EACH ROW
	BEGIN
	UPDATE Prodotti SET Prodotti.Giacenza = Prodotti.Giacenza + NEW.QuantitaOrdinata
	where NEW.CodiceProdotto = Prodotti.CodiceProdotto;
	END $$

	DELIMITER ;

	INSERT into FattureAzienda values ("AX81729312", 9018, 500, 5);

############################################################################
################   	Interrogazioni   		   #################
############################################################################

# Possibilmente di vario tipo:  selezioni, proiezioni, join, con raggruppamento, 
# annidate, con funzioni per il controllo del flusso.

#1)selezionare i fornitori che hanno un capitale di debito inferiore alla media

#tutti tranne azienda asus
SELECT 
    *
FROM
    FornitoriAzienda
WHERE
    CapitaleDiDebito < (SELECT 
            AVG(CapitaleDiDebito)
        FROM
            FornitoriAzienda);

#2)Trovare codice,cognome,nome di tutti i clienti che non hanno effettuato ordini nell'anno 2019

SELECT DISTINCT
    CodiceCliente, Cognome, Nome
FROM
    Clienti
        NATURAL JOIN
    CarrelliClienti
WHERE
    CodiceCliente NOT IN (SELECT 
            CodiceCliente
        FROM
            CarrelliClienti
        WHERE
            data LIKE '2019%');

#3)Mostrare codice del prodotto,PrezzoUnitario,Giacenza,categoria,quantitaordinata di
#tutti i prodotti di un determinato ordine classificati per quantità che sono della categoria multimedia e che sono nell'ordine avente idcarrello 90.
#mostrare anche la data dell'acquisto

SELECT 
    P.CodiceProdotto,
    P.PrezzoUnitario,
    P.Giacenza,
    P.Categoria,
    C2.data,
    C1.QuantitaOrdinata
FROM
    Prodotti P
        NATURAL JOIN
    DettagliCarrelloClienti C1
        NATURAL JOIN
    CarrelliClienti C2
WHERE
    P.Categoria = 'Multimedia'
        AND C1.IdCarrello = 90
ORDER BY C1.QuantitaOrdinata; 

#4)Il cliente Neera Manfrin ha sbagliato e vorrebbe aggiornare il suo ultimo ordine decrementando il numero di tablet presenti nel suo carrello di 1

select * from DettagliCarrelloClienti where CodiceProdotto = "MP01AJKSHQ" AND IdCarrello = 90;

#max data ritorna la data più recente tra 2 date in questo caso la data più recente tra 2 ordini effettuati da uno stesso cliente

UPDATE DettagliCarrelloCLienti D
        JOIN
    CarrelliClienti C0 ON C0.IdCarrello
        JOIN
    Clienti C1 ON C1.CodiceCliente 
SET 
    QuantitaOrdinata = QuantitaOrdinata - 1
WHERE
    C1.Nome = 'Neera'
        AND C1.Cognome = 'Manfrin'
        AND C1.CodiceCliente = C0.CodiceCliente
        AND (SELECT 
            MAX(data)
        FROM
            CarrelliClienti)
AND C0.IdCarrello = D.IdCarrello
AND D.CodiceProdotto in (SELECT CodiceProdotto FROM Prodotti WHERE Descrizione = "Tablet");

SELECT * FROM DettagliCarrelloClienti WHERE CodiceProdotto = 'MP01AJKSHQ' AND IdCarrello = 90;

#5)Selezionare il numero di clienti che hanno meno di 2000 punti acquisto e sono di catanzaro
SELECT 
    *
FROM
    Clienti
WHERE
    PuntiAcquisto < 2000
        AND Citta = 'Catanzaro';

#6)trovare la somma dei prezzi dei prodotti acquistati dai clienti dove il numero di pezzi acquistati è > 1 e la somma totale è maggiore di 300 euro
SELECT 
    IdCarrello,
    SUM(D.QuantitaOrdinata * P.PrezzoUnitario) AS TOTALE
FROM
    DettagliCarrelloClienti D
        NATURAL JOIN
    Prodotti P
WHERE
    D.QuantitaOrdinata > 1
GROUP BY IdCarrello
HAVING TOTALE > 300
ORDER BY TOTALE;

#7)Trovare la partita iva dei fornitori degli ordini gestiti dal dipendente Alice Milani 
#che hanno venduto più di 10 pezzi.
SELECT DISTINCT
    F.PartitaIva, F.NomeAzienda
FROM
    FornitoriAzienda F,
    OrdineMerceAzienda O,
    Dipendenti D
WHERE
    O.IdFornitore = F.PartitaIva
        AND O.CodiceDipendente = (SELECT 
            CodiceDipendente
        FROM
            Dipendenti
        WHERE
            Nome = 'Alice' AND Cognome = 'Milani')
        AND (SELECT 
            SUM(QuantitaOrdinata)
        FROM
            FattureAzienda F2
        WHERE
            F2.NumeroOrdine = O.NumeroOrdine) > 10;

#8)elencare tutte le fatture e la loro data di emissione in base al numero dell'ordine, gestite dal dipendente che ha codice fiscale ZC31322934 nell'anno 2019 
SELECT 
    D.Nome, D.Cognome, NumeroOrdine, SUM(PrezzoTotale), O.Data
FROM
    FattureAzienda AS F
        NATURAL JOIN
    OrdineMerceAzienda O
        NATURAL JOIN
    Dipendenti D
WHERE
    D.CDF = 'ZC31322934'
        AND O.Data LIKE '2019%'
GROUP BY NumeroOrdine
ORDER BY NumeroOrdine;


#9)Trovare i dipendenti che hanno provveduto alla gestione di un carrello con prodotti del non loro stesso reparto di competenza.
SELECT 
    Dipendenti.CodiceDipendente,
    Dipendenti.Reparto AS RepartoDiCompetenza,
    Prodotti.Categoria AS CategoriaProdottoVenduto
FROM
    Dipendenti
        NATURAL JOIN
    CarrelliClienti
        NATURAL JOIN
    DettagliCarrelloClienti
        NATURAL JOIN
    Prodotti
WHERE
    Dipendenti.Reparto != Prodotti.Categoria;


#10)#10)Elencare per ogni punto vendita il numero di dipendenti che lavorano per ogni reparto.

SELECT 
    IdPuntoVendita, COUNT(*) AS NumeroDipendenti, Reparto
FROM
    Dipendenti
GROUP BY IdPuntoVendita , Reparto;


#11)Trovare tutti gli ordini di merce effettuate tra 2017-10-16 e 2019-03-10.
SELECT 
    *
FROM
    OrdineMerceAzienda
WHERE
    data BETWEEN ('2017-10-16') AND ('2019-03-10')
ORDER BY DATA;

#12)Trovare il nome dell'azienda e partita iva che ha venduto il prodotto "Mouse per pc" recepito dal dipendente di nome Flavio Lucciano.
SELECT 
    NomeAzienda, PartitaIva
FROM
    FornitoriAzienda F
        JOIN
    OrdineMerceAzienda O ON F.PartitaIva = O.IdFornitore
        NATURAL JOIN
    FattureAzienda F2
        NATURAL JOIN
    Prodotti P
WHERE
    O.CodiceDipendente = (SELECT 
            CodiceDipendente
        FROM
            Dipendenti
        WHERE
            Nome = 'Flavio' AND Cognome = 'Lucciano')
        AND P.Descrizione = 'Mouse per pc';

#13)Trovare il numero dell'ordine di merce gestito dal dipendente di codice 10 i cui prodotti sono stati venduti al cliente di ID 6.
SELECT DISTINCT
    OrdineMerceAzienda.NumeroOrdine
FROM
    OrdineMerceAzienda,
    FattureAzienda,
    DettagliCarrelloClienti,
    CarrelliClienti,
    Dipendenti,
    Clienti
WHERE
    OrdineMerceAzienda.NumeroOrdine = FattureAzienda.NumeroOrdine
        AND FattureAzienda.CodiceProdotto = DettagliCarrelloClienti.CodiceProdotto
        AND DettagliCarrelloClienti.IdCarrello = CarrelliClienti.IdCarrello
        AND CarrelliClienti.CodiceDipendente = Dipendenti.CodiceDipendente
        AND Dipendenti.CodiceDipendente = 10
        AND Clienti.CodiceCliente = 6;


#14)seleziona i carrelli dove c'è il prodotto di costo massimo rispetto a tutti gli altri prodotti (sarebbe la televisione). 


SELECT DISTINCT
    DettagliCarrelloClienti.IdCarrello,
    Prodotti.Descrizione,
    DettagliCarrelloClienti.QuantitaOrdinata
FROM
    Prodotti
        NATURAL JOIN
    DettagliCarrelloClienti
WHERE
    Prodotti.PrezzoUnitario IN (SELECT 
            MAX(Prodotti.PrezzoUnitario)
        FROM
            Prodotti
                NATURAL JOIN
            DettagliCarrelloClienti);  


#15)elencare per ogni carrello il costo massimo presente al suo interno

SELECT 
    DettagliCarrelloClienti.IdCarrello,
    MAX(Prodotti.PrezzoUnitario) AS massimo
FROM
    Prodotti
        NATURAL JOIN
    DettagliCarrelloClienti
GROUP BY idcarrello;

#16)Trovare quantità ordinata e prezzo totale dei carrelli acquistati in una determinata data (o in un perieodo) dai clienti che hanno un punteggio dei punti acquisto maggiore di 500

SELECT 
    DettagliCarrelloClienti.QuantitaOrdinata,
    SUM(DettagliCarrelloClienti.QuantitaOrdinata * Prodotti.PrezzoUnitario) AS PrezzoTotale
FROM
    Clienti
        NATURAL JOIN
    CarrelliClienti
        NATURAL JOIN
    DettagliCarrelloClienti
        NATURAL JOIN
    Prodotti
WHERE
    Clienti.PuntiAcquisto > 500
        AND CarrelliClienti.data BETWEEN '2016-09-17' AND '2019-06-06'
GROUP BY DettagliCarrelloClienti.QuantitaOrdinata;


#17)Calcolare ed inserire il prezzo totale nella tabella fatture in base ai prodotti e alla quantità
SET SQL_SAFE_UPDATES=0; #per bypassare la safe update mode di mysql la quale dice che non è possibile usare update se non si opera con una colonna che usi una key

UPDATE FattureAzienda AS F 
SET 
    F.PrezzoTotale = ((SELECT 
            PrezzoUnitario
        FROM
            Prodotti P
        WHERE
            F.CodiceProdotto = P.CodiceProdotto) * QuantitaOrdinata);

#18)Trovare tutti i dipendenti che lavorano in un punto vendita comune e indicarne la città in cui lavorano (Ordinare in base alla città)
SELECT DISTINCT
    D.CodiceDipendente, D.Nome, D.Cognome, PV.Citta
FROM
    Dipendenti D
        JOIN
    PuntiVendita PV
WHERE
    D.IdPuntoVendita = PV.IdPuntoVendita
ORDER BY PV.citta;

#19)Trovare il dipendente/i che ha gestito più prodotti e il dipendente/i che ne ha gestiti meno. Selezionare tutti 
#i dipendenti aventi uguale numero di TotaleOrdiniGestiti se ci sono più dipendenti con lo stesso numero di ordini gestiti.
#L'importante è che NON ci siano altri ordini numericamente maggiori di quelli che hanno venduto di più e numericamente inferiori
#rispetto a quelli che hanno venduto meno.

##################### GUARDARE NELLA SEZIONE VISTE PER LA CREAZIONE DELLA VISTA #################
    
SELECT 
    Nome, Cognome, TotaleOrdiniGestiti
FROM
    TotaleProdottiVendutiDaiDipendenti
WHERE
    TotaleOrdiniGestiti IN (SELECT 
            MAX(TotaleOrdiniGestiti)
        FROM
            TotaleProdottiVendutiDaiDipendenti) 
UNION SELECT 
    Nome, Cognome, TotaleOrdiniGestiti
FROM
    TotaleProdottiVendutiDaiDipendenti
WHERE
    TotaleOrdiniGestiti IN (SELECT 
            MIN(TotaleOrdiniGestiti)
        FROM
            TotaleProdottiVendutiDaiDipendenti);


#20)Per tutti i clienti aventi diritto allo sconto trovare i dipendenti che hanno gestiti i loro ordini

SELECT DISTINCT
    D.CodiceDipendente,
    D.Nome AS NomeDipendente,
    D.Cognome AS CognomeDipendente,
    C.nome,
    C.Cognome
FROM
    Dipendenti D
        NATURAL JOIN
    CarrelliClienti C0
        JOIN
    Clienti C ON C0.CodiceCliente = C.CodiceCliente
WHERE
    C.nome IN (SELECT 
            nome
        FROM
            AventiDirittoSconto)
        AND C.cognome IN (SELECT 
            cognome
        FROM
            aventidirittosconto);

#21) Mostrare per ogni carrello tutti i prodotti acquistati al suo interno mantenendo tutte le info di tutti i carrelli(right join) 
#non vi sono elementi null creati dal right join perchè combaciano tutti in questo caso, quindi anche un join normale andava benissimo.

SELECT DISTINCT
    *
FROM
    Prodotti P
		RIGHT JOIN
    DettagliCarrelloClienti D USING (CodiceProdotto)
GROUP BY IdCarrello , CodiceProdotto , P.Descrizione
ORDER BY IdCarrello;

#21.1) Trovare per ogni cliente residente in una città tutte le informazioni sul punto vendita situato nella sua stessa città.
#Mantenere le informazioni sul cliente se tale punto vendita non esiste.
#esempio dove right join riporta campi null: il cliente Giuseppe Antonino è residente in una città (BustoArstizio)
#non presente in PuntiVendita, ma si mostrano le informazioni del cliente ugualmente.

SELECT DISTINCT
    *
FROM
    PuntiVendita P
		RIGHT JOIN
    Clienti C ON P.Citta = C.Citta;


#22)Mostrare per ogni fornitore che ha venduto prodotti all'azienda, la quantità maggiore di prodotti venduta in un singolo ordine.

SELECT 
    F.PartitaIva,
    F.NomeAzienda,
    MAX(D.QuantitaOrdinata) AS PiuVenduti
FROM
    FornitoriAzienda F
        JOIN
    OrdineMerceAzienda O ON F.PartitaIva = O.IdFornitore
        JOIN
    CarrelliClienti C ON O.CodiceDipendente = C.CodiceDipendente
        JOIN
    DettagliCarrelloCLienti D ON D.IdCarrello = C.IdCarrello
GROUP BY F.PartitaIva , F.NomeAzienda;

#23)Trovare i clienti che sono residenti in una città dove non vi è alcun punto vendita.

SELECT DISTINCT
    C.nome, C.cognome
FROM
    Clienti C,
    PuntiVendita PV
WHERE
    C.citta NOT IN (SELECT 
            Citta
        FROM
            PuntiVendita);


#24)trovare il numero degli ordini venduti per ogni punto vendita 

SELECT 
    P.Citta, COUNT(*) AS NumeroOrdini
FROM
    PuntiVendita P
        JOIN
    Dipendenti D ON P.IdPuntoVendita = D.IdPuntoVendita
        JOIN
    CarrelliClienti C ON D.CodiceDipendente = C.CodiceDipendente
GROUP BY P.Citta;

#25)Raccogliere tutte le date in cui il Cliente Francesco Maida ha fatto un ordine di un prodotto fornito all'azienda dal fornitore AntComputer

SELECT DISTINCT
    CC.data
FROM
    Clienti C,
    CarrelliClienti CC,
    DettagliCarrelloClienti DC,
    FattureAzienda FA,
    OrdineMerceAzienda O,
    FornitoriAzienda FO
WHERE
    CC.IdCarrello = DC.IdCarrello
        AND DC.CodiceProdotto = FA.CodiceProdotto
        AND CC.CodiceCliente = C.CodiceCliente
        AND C.nome = 'Francesco'
        AND Cognome = 'Maida'
        AND O.IdFornitore = FO.PartitaIva
        AND FO.NomeAzienda = 'AntComputer';

#25)Ricercare tutti gli ordini dei clienti che comprendono una quantità di prodotti superiore alla media della quantità dello stesso prodotto negli ordini dall'azienda AntComputer

SELECT 
    *
FROM
    CarrelliClienti CC
        NATURAL JOIN
    DettagliCarrelloClienti DC
WHERE
    DC.QuantitaOrdinata > (SELECT 
            AVG(QuantitaOrdinata)
        FROM
            OrdineMerceAzienda O
                NATURAL JOIN
            FornitoriAzienda FO
                NATURAL JOIN
            FattureAzienda FA
        WHERE
            O.IdFornitore = FO.PartitaIva
                AND FO.NomeAzienda = 'AntComputer');


############################################################################
################          Procedure e funzioni             #################
############################################################################

# Per la consegna del 25 maggio non sono richiesti handler e cursori.

#1)Creare una procedura per generare una sequenza alfanumerica pseudocasuale per i codice della tabella prodotti
#questa ovviamente deve anche verificare che non esistano altri prodotti con lo stesso codice. Ritentare finchè non viene generato un codice valido qualora dovesse
#verificarsi il seocondo caso

DELIMITER $$
DROP PROCEDURE IF EXISTS GENERATOR $$
CREATE PROCEDURE generator(OUT RES VARCHAR(25)) comment 'generator'
BEGIN
	DECLARE T INT;
	DECLARE STRING_LENGTH INT;
    DECLARE TEMP INT DEFAULT 0;
    DECLARE RESULT VARCHAR(25) DEFAULT "";       
    DECLARE SINGLECHAR CHAR(1);
SELECT FLOOR(RAND() * (26 - 10) + 10) INTO STRING_LENGTH; #26 perchè n-1 nel while successivo minore e non minore uguale. floor = arrotondamento ad int da decimal
	WHILE TEMP < STRING_LENGTH DO
		SET T = FLOOR(RAND()*(36));
		SET SINGLECHAR = substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', t,1);
        SET RESULT = CONCAT(RESULT,SINGLECHAR);
        SET TEMP = TEMP + 1;
	END WHILE;
    SET RES = RESULT;
END $$    
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS alphanumericgenerator $$
CREATE PROCEDURE alphanumericgenerator(IN PrzUnt INT, IN Descrizione VARCHAR(100), IN Categoria VARCHAR(30), IN Giacenza INT)
COMMENT 'GENERA IL CODICE PSEUDO CASUALE DA ASSEGNARE A PRODOTTI.CODICEPRODOTTO'
BEGIN 
	DECLARE TEMP VARCHAR(25); 
	CALL generator(@var);
	SET TEMP = @var;
	WHILE (EXISTS (SELECT CodiceProdotto FROM Prodotti WHERE CodiceProdotto=TEMP)) DO
    	CALL generator(@var);
		SET TEMP = @var;
    END WHILE ;
    INSERT INTO Prodotti VALUES (TEMP,PrzUnt,Descrizione,Categoria,Giacenza);
END $$
DELIMITER ;

CALL alphanumericgenerator(10,"TestProdotto","TestProdotto",10);

#2)Creare una procedura per eliminare tutti i record nella tabella carrelli dove la data è null

DROP PROCEDURE IF EXISTS EliminateNoDate;
DELIMITER $$
CREATE PROCEDURE EliminateNoDate()
BEGIN
	delete from CarrelliClienti
    where CarrelliClienti.data is null;
END $$
DELIMITER ;

CALL EliminateNoDate();

#3) Creare una Procedura che in base alla vista dei clienti che hanno diritto allo sconto calcoli il prezzo effettivo nel caso volessi riscattare quel prodotto 
#	(quindi calcola lo sconto percentuale su ogni prodotto possibile). La procedura per il calcolo usa una funzione, considerare la quantità da acquistare in input alla procedura (e quindi 
#	transitivamente alla funzione)


DELIMITER $$
DROP FUNCTION IF EXISTS CalculateDiscount $$
CREATE FUNCTION CalculateDiscount(PrezzoUnitario int, QuantitaAquistata int , PercentualeSconto bigint) RETURNS int DETERMINISTIC
BEGIN
	DECLARE DiscountedValue int;
	SET DiscountedValue = (((PrezzoUnitario * QuantitaAquistata) * PercentualeSconto) / 100);
    RETURN DiscountedValue;
END $$

DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS DiscountedCalculate $$
CREATE PROCEDURE DiscountedCalculate(QuantAcquist int) 
BEGIN
SELECT DISTINCT
    CodiceProdotto, 
    (PrezzoUnitario * QuantAcquist) - CalculateDiscount(PrezzoUnitario, QuantAcquist, PercentualeSconto) AS PrezzoTotaleScontato,
    CalculateDiscount(PrezzoUnitario, QuantAcquist, PercentualeSconto) AS Sconto,
    Nome,
    Cognome
FROM
    Prodotti
        NATURAL JOIN
    DettagliCarrelloClienti
        NATURAL JOIN
    CarrelliClienti
        NATURAL JOIN
    AventidirittoSconto;
END $$

DELIMITER ;

CALL DiscountedCalculate(2);
