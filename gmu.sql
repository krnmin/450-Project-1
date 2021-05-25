/*Deletes all tables in the beginning */
DROP TABLE movie cascade constraints;
DROP TABLE productionCompany cascade constraints;
DROP TABLE critic cascade constraints;
DROP TABLE actors cascade constraints;
DROP TABLE produced cascade constraints;
DROP TABLE criticReview cascade constraints;
DROP TABLE foreignMovie cascade constraints;
DROP TABLE domesticMovie cascade constraints;
DROP TABLE awards cascade constraints;

/*table declarations*/
CREATE TABLE movie(
    MID INT PRIMARY KEY,
    releaseDate DATE NOT NULL,
    rating VARCHAR(5) NOT NULL,
    director VARCHAR(50) NOT NULL,
    runningTime INT NOT NULL ,
    title VARCHAR(255) NOT NULL
);
/*
INSERT INTO movie(MID,releaseDate,rating,director,runningTime,title) 
VALUES (0, TO_DATE ('2020-10-16', 'YYYY/MM/DD') , 'PG' , 'director hack' , 55, 'movie0');
*/
CREATE TABLE productionCompany(
    PID INT PRIMARY KEY,
    address VARCHAR(255) ,
    moviesProduced INT,
    phoneNumber CHAR(12),
    companyName VARCHAR(255)
);


CREATE TABLE critic(
    CID INT PRIMARY KEY,
    criticName VARCHAR(255),
    moviesReviewed VARCHAR(255)
);

CREATE TABLE actors(
    AName VARCHAR(50)NOT NULL,
    movieID INT NOT NULL,
    CONSTRAINT fkActors FOREIGN KEY (movieID) REFERENCES movie(MID)
);


/*foreign keys movie id and production id */
CREATE TABLE produced(
    PID INT,
    MID INT,
    CONSTRAINT produced_FK_MID FOREIGN KEY (MID) REFERENCES movie(MID),
    CONSTRAINT produced_FK_PID FOREIGN KEY (PID) REFERENCES productionCompany(PID)
);

/* references critics CID and movies MID*/
CREATE TABLE criticReview(
    CID INT,
    MID INT,
    score INT,
    check (score < 6),
    check (score >0),
    CONSTRAINT review_FK_MID FOREIGN KEY (MID) REFERENCES movie(MID),
    CONSTRAINT review_FK_CID FOREIGN KEY (CID) REFERENCES critic(CID)
    
);

CREATE TABLE foreignMovie(
    MID INT,
    CONSTRAINT foreign_FK_MID FOREIGN KEY (MID) REFERENCES movie(MID),
    subtitle SMALLINT,
    movieLang VARCHAR(50)
);

CREATE TABLE domesticMovie(
    MID INT,
    CONSTRAINT domestic_FK_MID FOREIGN KEY (MID) REFERENCES movie(MID),
    isHorror SMALLINT default 0,
    isAction SMALLINT default 0,
    isComedy SMALLINT default 0,
    isDrama SMALLINT default 0,
    dramaDesc VARCHAR(255),
    funLevel INT,
    check(funLevel >0),
    check(funLevel <6)
);

CREATE TABLE awards(
    awardID INT NOT NULL,
    otherNominees INT,
    awardYear INT,
    isWinner SMALLINT NOT NULL,
    awardName varChar(500) ,
    MID INT,
    CONSTRAINT awards_FK_MID FOREIGN KEY (MID) REFERENCES movie(MID)
);

INSERT ALL
    INTO movie(MID,releaseDate,rating,director,runningTime,title) VALUES (0, TO_DATE ('2018/10/16', 'YYYY/MM/DD') , 'PG' , 'director hack' , 55, 'comedy1 IN LOS ANGELES NOMINATED WINNER')
    INTO domesticMovie(MID, isComedy,funLevel) VALUES(0,1,4)
    
    INTO movie(MID,releaseDate,rating,director,runningTime,title) VALUES (1, TO_DATE ('2018/11/16', 'YYYY/MM/DD') , 'PG-13' , 'badboydirector' , 130, 'foreignMovie1 NOT IN LOS ANGELES NOMINATED NOT WINNER')
    INTO FOREIGNMOVIE(MID,SUBTITLE,MOVIELANG) VALUES (1,0,'language')
    
    INTO movie(MID,releaseDate,rating,director,runningTime,title) VALUES (2, TO_DATE ('2005/01/16', 'YYYY/MM/DD') , 'R' , 'im fake af' , 120, 'actionMovie 1')    
    INTO domesticMovie(MID,isAction) VALUES(2,1)
    
    INTO movie(MID,releaseDate,rating,director,runningTime,title) VALUES (3, TO_DATE ('2005/01/16', 'YYYY/MM/DD') , 'R' , 'Troma Films' , 120, 'HORROR FILM BY TROMA FILMS 1')    
    INTO domesticMovie(MID,ISHORROR) VALUES(3,1)
    
    INTO movie(MID,releaseDate,rating,director,runningTime,title) VALUES (4, TO_DATE ('2015/04/14', 'YYYY/MM/DD') , 'R' , 'John Woo' , 150, 'JOHN WOO FILM 1 REVIEWED BY ROGER EBERT')
    INTO domesticMovie(MID,ISACTION) VALUES(4,1)
    
    INTO movie(MID,releaseDate,rating,director,runningTime,title) VALUES (40, TO_DATE ('2015/04/14', 'YYYY/MM/DD') , 'R' , 'John Woo' , 150, 'JOHN WOO FILM 2 REVIEWED BY ROGER EBERT')
    INTO domesticMovie(MID,ISACTION) VALUES(40,1)
    
    INTO movie(MID,releaseDate,rating,director,runningTime,title) VALUES (5, TO_DATE ('2015/04/14', 'YYYY/MM/DD') , 'R' , 'John Woo' , 150, 'FILM reviewed by both critics')    
    INTO domesticMovie(MID,ISACTION) VALUES(5,1)
    
    INTO movie(MID,releaseDate,rating,director,runningTime,title) VALUES (6, TO_DATE ('1005/01/16', 'YYYY/MM/DD') , 'R' , 'Troma Films DIRECTOR GUY' , 122, 'HORROR FILM BY TROMA FILMS 2')    
    INTO domesticMovie(MID,ISHORROR) VALUES(6,1)
    INTO productionCompany(PID,address,moviesProduced,phoneNumber,companyName) VALUES(20, 'WRINKYL, BVONGTONG, 23213',223,'123-123-3212','Troma Films')   
    INTO produced(PID,MID) VALUES(20,6)
    
    INTO movie(MID,releaseDate,rating,director,runningTime,title) VALUES (3232, TO_DATE ('1205/01/16', 'YYYY/MM/DD') , 'R' , 'Troma Films DIRECTOR GUY22' , 122, 'TROMA FILMS 3')    
    INTO domesticMovie(MID,ISHORROR) VALUES(3232,1)
    INTO produced(PID,MID) VALUES(20,3232)
    
    INTO movie(MID,releaseDate,rating,director,runningTime,title) VALUES (7, TO_DATE ('1005/01/16', 'YYYY/MM/DD') , 'R' , 'Troma Films' , 122, 'NOT HORROR FILM BY TROMA FILMS 2')    
    INTO domesticMovie(MID,isComedy,funlevel,isdrama,dramadesc) VALUES(7,1,5,1,'drama comedy by troma films')
    
    INTO movie(MID,releaseDate,rating,director,runningTime,title) VALUES (8, TO_DATE ('4005/12/06', 'YYYY/MM/DD') , 'G' , 'BAD COMEDY FILMS' , 240, 'COMEDY FILM 1 STAR WITH PAULY SHORE')
    INTO ACTORS(Aname,MOVIEID) VALUES('Pauly Shore',8)
    INTO domesticMovie(MID,isComedy,funLevel) VALUES (8,1,1)
    
    INTO movie(MID,releaseDate,rating,director,runningTime,title) VALUES (9, TO_DATE ('1205/12/06', 'YYYY/MM/DD') , 'R' , 'BAD COMEDY FILMS' , 240, 'COMEDY FILM 1 STAR WITHOUT PAULY SHORE')
    INTO actors(AName,MOVIEID) VALUES('NOT OUR BOY Shore',8)
    INTO awards(AWARDID,OTHERNOMINEES,AWARDYEAR,ISWINNER,AWARDNAME,MID) VALUES (2012,123,2015,0,'award 4',8)
    INTO awards(AWARDID,OTHERNOMINEES,AWARDYEAR,ISWINNER,AWARDNAME,MID) VALUES (2011,123,2015,0,'award 3',8)

    INTO critic(CID,criticName,moviesReviewed) VALUES(0,'Roger Ebert', 200)
    INTO criticReview(CID,MID,score) VALUES(0,0,5)
    INTO criticReview(CID,MID,score) VALUES(0,4,4)
    INTO criticReview(CID,MID,score) VALUES(0,6,3)
    INTO criticReview(CID,MID,score) VALUES(0,40,2)

    INTO critic(CID,criticName,moviesReviewed) VALUES(1,'Not EBERT', 1200)
    INTO criticReview(CID,MID) VALUES(1,5)
    INTO criticReview(CID,MID) VALUES(1,0)
    
    INTO productionCompany(PID,address,moviesProduced,phoneNumber,companyName) VALUES(0,'Los Angeles',500,'999-999-9999','LOS ANGELES COMPANY 1')
    INTO produced(PID,MID) VALUES(0,0)
    INTO productionCompany(PID,address,moviesProduced,phoneNumber,companyName) VALUES(5,'okalsdjfl;aksd,Los Angeles,aslkdjfasldf',500,'999-999-9999','LOS ANGELES COMPANY 2')
    INTO productionCompany(PID,address,moviesProduced,phoneNumber,companyName) VALUES(6,'12341234,Los Angeles,1234',500,'999-999-9999','LOS ANGELES COMPANY 3')
    INTO productionCompany(PID,address,moviesProduced,phoneNumber,companyName) VALUES(7,'1234,Los Angeles,1234',500,'999-999-9999','LOS ANGELES COMPANY 4')
    INTO productionCompany(PID,address,moviesProduced,phoneNumber,companyName) VALUES(1, '1234,WRINKYL, BVONGTONG,1234, 23213',223,'123-123-3212','NOT LA COMPANY 1')   
    INTO produced(PID,MID) VALUES(1,1)
    
    INTO actors(aName,MovieID) VALUES ('i am an actor that is in a movie that won 2 awards', 0)
    INTO actors(aname,movieId) VALUES ('I AM ACTOR 2 in a movie with 2 awarrds',0)
    
    INTO awards(AWARDID,otherNominees,AwardYear,isWinner,MID,awardName) VALUES(0,12,2018,1,0,'award0')
    INTO awards(AWARDID,otherNominees,AwardYear,isWinner,MID,awardName) VALUES(1,12,2002,1,2,'award1')
    INTO awards(AWARDID,otherNominees,AwardYear,isWinner,MID,awardName) VALUES(2,12,2002,1,0,'award2')
    
    INTO movie(MID,releaseDate,rating,director,runningTime,title) VALUES (500, TO_DATE ('5000/05/15', 'YYYY/MM/DD') , 'PG' , 'BEST MOVIE' , 500, 'THIS IS 5 STAR AVERAGE MOVIE')    
    INTO criticReview(MID,CID,score) VALUES(500,0,5)
    INTO criticReview(MID,CID,score) VALUES(500,0,5)
    INTO criticReview(MID,CID,score) VALUES(500,1,5)
    
    INTO movie(MID,releaseDate,rating,director,runningTime,title) VALUES (123, TO_DATE ('2018/10/16', 'YYYY/MM/DD') , 'PG' , 'director hack' , 55, 'COMEDY = 1 MOVIE')
    INTO domesticMovie(MID, isComedy,funLevel) VALUES(123,1,1)
    INTO actors(aName,MOVIEID) VALUES('Pauly Shore' , 123)
    
    INTO critic(CID,CRITICNAME,MOVIESREVIEWED) VALUES(3,'bingle',1)
    INTO criticReview(CID,MID,Score) VALUES (3,500,5)
    
SELECT * FROM dual;

	/*1. production companies in los angeles*/
    SELECT companyName
    FROM productionCompany
    WHERE REGEXP_LIKE(address,'Los Angeles','i');
	
    
    /*2. title,release date, and running time of every movie nominated in 2018*/
    SELECT title, releaseDate,runningTime, movie.MID
    FROM movie JOIN awards on movie.MID = awards.MID
    Where awards.awardYear = 2018;
	
    /*3. directors of horror movies produced by troma films */
    SELECT director
    FROM movie 
    WHERE MID IN 
        (SELECT MID
        FROM ProductionCompany JOIN Produced on produced.PID = productionCompany.PID
        WHERE REGEXP_LIKE(companyName,'Troma Films','i'));
        
		
	/*4. one star comedies with pauly shore*/	
    SELECT title
    FROM movie JOIN domesticMovie on movie.MID = domesticMovie.MID
    WHERE funLevel= 1 AND  movie.MID IN (SELECT movieID FROM actors WHERE REGEXP_LIKE(aName,'Pauly Shore','i'));
    
	/*5. john woo action film reviewed by roger ebert*/
    SELECT title
    FROM movie JOIN criticReview on movie.MID = criticReview.MID join domesticMovie on domesticMovie.MID = movie.MID
    WHERE isAction = 1 AND REGEXP_LIKE(director,'John Woo','i') AND CID IN (SELECT CID FROM critic WHERE REGEXP_LIKE(criticName,'Roger Ebert','i'));
    
    /*6. Find the actors of every movie that has won at least two awards. */
    select aname
    from actors
    where movieID in(
    select  c1.MID
    FROM awards c1, awards c2
    WHERE c1.MID = c2.MID
    AND c1.awardid <> c2.awardid
    AND c1.isWinner = 1 AND c2.isWinner = 1)
    ;
    /*7. average score = 5*/
    SELECT count(count(MID)) as count5
    FROM movie JOIN criticReview using(MID)
    GROUP BY MID
    HAVING AVG(score)=5;
	
    /*8. Movies never nominated*/
    Select title 
    FROM movie
    Where MID not in(select MID from awards);

    /*9. Find the title of every movie that has been reviewed by all critics.*/
    /*should only be movie MID 5*/
    SELECT Title,mid
    FROM movie m1
    WHERE NOT EXISTS
    ((SELECT CID from critic) MINUS (SELECT CID FROM criticReview m2 WHERE m1.MID=m2.MID))    
    ;

