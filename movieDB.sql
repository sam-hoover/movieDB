.headers on
.mode columns
.width 30
.open movieDB.db

DROP TABLE MOVIE;
DROP TABLE ACTOR;
DROP TABLE DIRECTOR;
DROP TABLE SCREENWRITER;
DROP TABLE LOCATION;
DROP TABLE SONG;
DROP TABLE MOVIE_LOCATION;
DROP TABLE MOVIE_SONG;
DROP TABLE WRITTEN_BY;
DROP TABLE ACTED_IN;

CREATE TABLE DIRECTOR(
	d_ID INT NOT NULL CHECK(d_ID > 0 AND d_ID <= 99999),
	d_fname VARCHAR(20) NOT NULL,
	d_lname VARCHAR(20) NOT NULL,
	d_DOB DATE,
	d_gender CHAR(1) CHECK(d_gender = 'M' OR d_gender = 'F'),
	d_nationality VARCHAR(20),
	d_active_from DATE,
	PRIMARY KEY(d_ID)
);

CREATE TABLE MOVIE(
	m_title VARCHAR(60) NOT NULL,
	m_release_date DATE NOT NULL,
	genre VARCHAR(15),
	minutes INT,
	language VARCHAR(20),
	m_director INT NOT NULL CHECK(m_director > 0 AND m_director <= 99999),
	m_producer VARCHAR(30),
	origin VARCHAR(20),
	PRIMARY KEY(m_title, m_release_date),
	FOREIGN KEY(m_director) REFERENCES DIRECTOR(d_ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ACTOR(
	a_ID INT NOT NULL CHECK(a_ID > 0 AND a_ID <= 99999),
	a_fname VARCHAR(20) NOT NULL,
	a_lname VARCHAR(20) NOT NULL,
	a_DOB DATE,
	a_gender CHAR(1) CHECK(a_gender = 'M' OR a_gender = 'F'),
	a_nationality VARCHAR(20),
	a_active_from DATE,
	PRIMARY KEY(a_ID)
);

CREATE TABLE SCREENWRITER(
	w_ID INT NOT NULL CHECK(w_ID > 0 AND w_ID <= 99999),
	w_fname VARCHAR(20) NOT NULL,
	w_lname VARCAHR(20) NOT NULL,
	w_DOB DATE,
	w_gender CHAR(1) CHECK(w_gender = 'M' OR w_gender = 'F'),
	w_nationality VARCHAR(20),
	w_active_from DATE,
	PRIMARY KEY(w_ID)
);

CREATE TABLE LOCATION(
	country VARCHAR(30) NOT NULL,
	region VARCHAR(30) NOT NULL,
	place VARCHAR(30) NOT NULL,
	PRIMARY KEY(country, region, place)
);

CREATE TABLE SONG(
	s_title VARCHAR(30) NOT NULL,
	s_artist VARCHAR(20) NOT NULL,
	s_release_date DATE NOT NULL,
	s_producer VARCHAR(30),
	album VARCHAR(80),
	PRIMARY KEY(s_title, s_artist, s_release_date)
);

CREATE TABLE MOVIE_LOCATION(
	movie VARCHAR(60) NOT NULL,
	movie_release DATE NOT NULL,
	country VARCHAR(30) NOT NULL,
	region VARCHAR(30) NOT NULL,
	place VARCHAR(30) NOT NULL,
	PRIMARY KEY(movie, movie_release, country, region, place),
	FOREIGN KEY(movie) REFERENCES MOVIE(m_title) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(movie_release) REFERENCES MOVIE(m_release_date) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(country) REFERENCES LOCATION(country) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(region) REFERENCES LOCATION(region) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(place) REFERENCES LOCATION(place) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE MOVIE_SONG(
	movie VARCHAR(60) NOT NULL,
	movie_release DATE NOT NULL,
	song VARCHAR(30) NOT NULL,
	song_release DATE NOT NULL,
	artist VARCHAR(20) NOT NULL,
	PRIMARY KEY(movie, movie_release, song, song_release, artist),
	FOREIGN KEY(movie) REFERENCES MOVIE(m_title) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(movie_release) REFERENCES MOVIE(m_release_date) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(song) REFERENCES SONG(s_title) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(song_release) REFERENCES SONG(s_release_date) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(artist) REFERENCES SONG(s_artist) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE WRITTEN_BY(
	movie VARCHAR(60) NOT NULL,
	movie_release DATE NOT NULL,
	writer INT NOT NULL CHECK(writer > 0 AND writer <= 99999),
	PRIMARY KEY(movie, movie_release, writer),
	FOREIGN KEY(movie) REFERENCES MOVIE(m_title) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(movie_release) REFERENCES MOVIE(m_release_date) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(writer) REFERENCES SCREENWRITER(w_ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ACTED_IN(
	movie VARCHAR(60) NOT NULL,
	movie_release DATE NOT NULL,
	actor INT NOT NULL CHECK(actor > 0 AND actor <= 99999),
	PRIMARY KEY(movie, movie_release, actor),
	FOREIGN KEY(movie) REFERENCES MOVIE(m_title) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(movie_release) REFERENCES MOVIE(m_release_date) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(actor) REFERENCES ACTOR(a_ID) ON UPDATE CASCADE ON DELETE CASCADE
);

/* DIRECTOR TABLE INSERT STATEMENTS */
INSERT INTO DIRECTOR VALUES(1000, 'George', 'Lucas', '1944-5-14', 'M', 'American', '1971-03-11');
INSERT INTO DIRECTOR VALUES(1001, 'Irvin', 'Kershner', '1923-4-29', 'M', 'American', '1961-03-26');
INSERT INTO DIRECTOR VALUES(1002, 'Richard', 'Marquand', '1937-9-22', 'M', 'British', '1978-09-14');
INSERT INTO DIRECTOR VALUES(1003, 'Peter', 'Jackson', '1961-10-31', 'M', 'New Zealander', '1987-12-11');
INSERT INTO DIRECTOR VALUES(1004, 'Stanley', 'Kubrick', '1928-7-26', 'M', 'American', '1951-04-26');
INSERT INTO DIRECTOR VALUES(1005, 'Rob', 'Reiner', '1947-3-6', 'M', 'American', '1984-03-02');
INSERT INTO DIRECTOR VALUES(1006, 'Mel', 'Brooks', '1926-6-28', 'M', 'American', '1968-03-18');
INSERT INTO DIRECTOR VALUES(1007, 'Harold', 'Ramis', '1944-11-21', 'M', 'American', '1980-07-25');
INSERT INTO DIRECTOR VALUES(1008, 'Ivan', 'Reitman', '1946-10-27', 'M', 'Canadian', '1971-09-27');
INSERT INTO DIRECTOR VALUES(1009, 'Joss', 'Whedon', '1964-6-23', 'M', 'American', '2005-08-22');
INSERT INTO DIRECTOR VALUES(1010, 'David', 'Fincher', '1962-8-28', 'M', 'American', '1922-5-22');


/* MOVIE TABLE INSERT STATEMENTS */
INSERT INTO MOVIE VALUES('Star Wars: Episode IV', '1977-05-25', 'Fantasy', 121, 'English', 1000, 'Lucasfilm Ltd', 'USA');
INSERT INTO MOVIE VALUES('Star Wars: Episode V', '1980-05-21', 'Fantasy', 124, 'English', 1000, 'Lucasfilm Ltd', 'USA');
INSERT INTO MOVIE VALUES('Star Wars: Episode VI', '1983-05-25', 'Fantasy', 131, 'English', 1000, 'Lucasfilm Ltd', 'USA');
INSERT INTO MOVIE VALUES('The Lord of the Rings: The Fellowship of the Ring', '2001-12-19', 'Fantasy', 178, 'English', 1003, 'WingNut Films', 'USA');
INSERT INTO MOVIE VALUES('The Lord of the Rings: The Two Towers', '2002-12-18', 'Fantasy', 179, 'English', 1003, 'WingNut Films', 'USA');
INSERT INTO MOVIE VALUES('The Lord of the Rings: The Return of the King', '2003-12-17', 'Fantasy', 201, 'English', 1003, 'WingNut Films', 'USA');
INSERT INTO MOVIE VALUES('2001: A Space Odessey', '1968-04-03', 'Sci-Fi', 148, 'English', 1004, 'Stanley Kubrick', 'USA');
INSERT INTO MOVIE VALUES('The Princess Bride', '1987-09-25', 'Adventure', 98, 'English', 1005, 'ACT III Communications', 'USA');
INSERT INTO MOVIE VALUES('Robin Hood: Men in Tights', '1993-07-28', 'Comedy', 104, 'English', 1006, 'Mel Brooks', 'USA');
INSERT INTO MOVIE VALUES('Caddyshack', '1980-07-25', 'Comedy', 98, 'English', 1007, 'Douglas Kenney', 'USA');
INSERT INTO MOVIE VALUES('Ghostbusters', '1984-06-08', 'Comedy', 107, 'English', 1008, 'Ivan Reitman', 'USA');
INSERT INTO MOVIE VALUES('Fight Club', '1999-10-15', 'Drama', 139, 'English', 1010, 'Art Linson', 'USA');

/* ACTOR TABLE INSERT STATEMENTS */
INSERT INTO ACTOR VALUES(10001, 'Bill', 'Murray', '1950-09-21', 'M', 'American', '1973-01-01'); /* Caddyshack */
INSERT INTO ACTOR VALUES(10002, 'Sigourney', 'Weaver', '1949-09-21', 'F', 'American', '1976-02-02'); /* Ghostbusters */
INSERT INTO ACTOR VALUES(10003, 'Ian', 'McKellen', '1939-05-22', 'M', 'British', '1959-01-01'); /* The Lord of the Rings */
INSERT INTO ACTOR VALUES(10004, 'Harrison', 'Ford', '1942-07-13', 'M', 'American', '1966-01-01'); /* Star Wars */
INSERT INTO ACTOR VALUES(10005, 'Robin', 'Wright', '1966-04-08', 'F', 'American', '1983-01-01'); /* The Princess Bride */
INSERT INTO ACTOR VALUES(10006, 'Brad', 'Pitt', '1963-12-18', 'M', 'American', '1987-01-01'); /* */
INSERT INTO ACTOR VALUES(10007, 'Scarlett', 'Johansson', '1984-11-22', 'F', 'American', '1994-01-01'); /* */
INSERT INTO ACTOR VALUES(10008, 'Cary', 'Elwes', '1969-11-04', 'M', 'British', '1979-01-01'); /* Robin Hood: Men in Tights */
INSERT INTO ACTOR VALUES(10009, 'Natalie', 'Portman', '1981-06-09', 'F', 'American', '1992-01-01'); /* */
INSERT INTO ACTOR VALUES(10010, 'Carrie', 'Fisher', '1956-10-21', 'F', 'American', '1973-01-01'); /* Star Wars */

/* SCREENWRITER TABLE INSERT STATEMENTS */
INSERT INTO SCREENWRITER VALUES(1, 'George', 'Lucas', '1944-05-14', 'M','American', '1971-01-01'); /* Star Wars Ep. 4-6*/
INSERT INTO SCREENWRITER VALUES(2, 'Lawrence', 'Kasdan', '1949-01-14', 'M', 'American', '1980-01-01'); /*Star Wars Ep. 5-6*/
INSERT INTO SCREENWRITER VALUES(3, 'Leigh', 'Brackett', '1915-12-07', 'F', 'American', '1945-01-01'); /*Star Wars Ep. 5*/
INSERT INTO SCREENWRITER VALUES(4, 'Fran', 'Walsh', '1959-01-10', 'F', 'New Zealander', '1983-01-01'); /*Lord of the Rings*/
INSERT INTO SCREENWRITER VALUES(5, 'Stephen', 'Sinclair', '1953-03-07', 'M', 'New Zealander', '1993-01-01'); /*The Two Towers*/
INSERT INTO SCREENWRITER VALUES(6, 'Arthur', 'Clark', '1917-12-16','M', 'British', '1946-01-01'); /*2001: A Space Odyssey*/
INSERT INTO SCREENWRITER VALUES(7, 'William', 'Goldman', '1931-08-12','M', 'American', '1963-01-01'); /*Princess Bride*/
INSERT INTO SCREENWRITER VALUES(8, 'Evan', 'Chandler', '1944-01-25','M', 'American', '1983-01-01'); /*Robin Hood*/
INSERT INTO SCREENWRITER VALUES(9, 'Brian', 'Doyle-Murray', '1945-10-31','M', 'American', '1972-01-01'); /*Caddyshack*/
INSERT INTO SCREENWRITER VALUES(10, 'Dan', 'Akroyd', '1952-07-01','M', 'American', '1971-01-01'); /*Ghostbusters*/

/* WRITTEN_BY TABLE INSERT STATEMENTS */
INSERT INTO WRITTEN_BY VALUES('Star Wars: Episode IV', '1977-05-25', 1);
INSERT INTO WRITTEN_BY VALUES('Star Wars: Episode V', '1980-05-21', 2);
INSERT INTO WRITTEN_BY VALUES('Star Wars: Episode V', '1980-05-21', 3);
INSERT INTO WRITTEN_BY VALUES('Star Wars: Episode VI', '1983-05-25', 2);
INSERT INTO WRITTEN_BY VALUES('The Lord of the Rings: The Fellowship of the Ring', '2001-12-19', 4);
INSERT INTO WRITTEN_BY VALUES('The Lord of the Rings: The Two Towers', '2002-12-18', 5);
INSERT INTO WRITTEN_BY VALUES('The Lord of the Rings: The Return of the King', '2003-12-17', 4);
INSERT INTO WRITTEN_BY VALUES('2001: A Space Odessey', '1968-04-03', 6);
INSERT INTO WRITTEN_BY VALUES('The Princess Bride', '1987-09-25', 7);
INSERT INTO WRITTEN_BY VALUES('Robin Hood: Men in Tights', '1993-07-28', 8);
INSERT INTO WRITTEN_BY VALUES('Caddyshack', '1980-07-25', 9);
INSERT INTO WRITTEN_BY VALUES('Ghostbusters', '1984-06-08', 10);

/* ACTED_IN TABLE INSERT STATEMENTS */
INSERT INTO ACTED_IN VALUES('Star Wars: Episode IV', '1977-05-25', 10004);
INSERT INTO ACTED_IN VALUES('Star Wars: Episode IV', '1977-05-25', 10010);
INSERT INTO ACTED_IN VALUES('The Princess Bride', '1987-09-25', 10005);
INSERT INTO ACTED_IN VALUES('Ghostbusters', '1984-06-08', 10001);
INSERT INTO ACTED_IN VALUES('Ghostbusters', '1984-06-08', 10002);
INSERT INTO ACTED_IN VALUES('Caddyshack', '1980-07-25', 10001);
INSERT INTO ACTED_IN VALUES('Star Wars: Episode V', '1980-05-21', 10004);
INSERT INTO ACTED_IN VALUES('Star Wars: Episode V', '1980-05-21', 10010);
INSERT INTO ACTED_IN VALUES('The Lord of the Rings: The Fellowship of the Ring', '2001-12-19', 10003);
INSERT INTO ACTED_IN VALUES('The Lord of the Rings: The Two Towers', '2002-12-18', 10003);
INSERT INTO ACTED_IN VALUES('Robin Hood: Men in Tights', '1993-07-28', 10008);
INSERT INTO ACTED_IN VALUES('Fight Club', '1999-10-15', 10006);

/* LOCATION TABLE INSERT STATEMENTS */
INSERT INTO LOCATION VALUES('USA', 'California', 'Santa Clarita'); /* Robin Hood */
INSERT INTO LOCATION VALUES('USA', 'New York', 'Brooklyn'); /* Ghostbusters */
INSERT INTO LOCATION VALUES('Norway', 'Finse', 'Hardangerjøkulen Glacier'); /* SW V */
INSERT INTO LOCATION VALUES('USA', 'California', 'Redwood National Park'); /* SW VI */
INSERT INTO LOCATION VALUES('USA', 'Florida', 'Davie'); /* Caddyshack */
INSERT INTO LOCATION VALUES('Ireland', 'County Clare', 'Cliffs of Moher'); /* Princess Bride */
INSERT INTO LOCATION VALUES('Scotland', 'Western Isles', 'Isle of Harris'); /* 2001 */
INSERT INTO LOCATION VALUES('New Zealand', 'Waikato', 'Hinuera Valley'); /* Return of the King*/
INSERT INTO LOCATION VALUES('New Zealand', 'Southern Alps', 'Mount Tasman'); /* Two Towers */
INSERT INTO LOCATION VALUES('New Zealand', 'Otago', 'Queenstown'); /* Fellowship */
INSERT INTO LOCATION VALUES('Tunisia', 'Jerba', 'Ajim'); /* SW IV */

/* MOVIE_LOCATION INSERT STATEMENTS */
INSERT INTO MOVIE_LOCATION VALUES('Star Wars: Episode IV', '1977-05-25', 'Tunisia', 'Jerba', 'Ajim');
INSERT INTO MOVIE_LOCATION VALUES('Star Wars: Episode V', '1980-05-21', 'Norway', 'Finse', 'Hardangerjøkulen Glacier');
INSERT INTO MOVIE_LOCATION VALUES('Star Wars: Episode VI', '1983-05-25', 'USA', 'California', 'Redwood National Park');
INSERT INTO MOVIE_LOCATION VALUES('Ghostbusters', '1984-06-08', 'USA', 'New York', 'Brooklyn');
INSERT INTO MOVIE_LOCATION VALUES('Caddyshack', '1980-07-25', 'USA', 'Florida', 'Davie');
INSERT INTO MOVIE_LOCATION VALUES('The Lord of the Rings: The Fellowship of the Ring', '2001-12-19', 'New Zealand', 'Otago', 'Queenstown');
INSERT INTO MOVIE_LOCATION VALUES('The Lord of the Rings: The Two Towers', '2002-12-18', 'New Zealand', 'Southern Alps', 'Mount Tasman');
INSERT INTO MOVIE_LOCATION VALUES('The Lord of the Rings: The Return of the King', '2003-12-17', 'New Zealand', 'Waikato', 'Hinuera Valley');
INSERT INTO MOVIE_LOCATION VALUES('2001: A Space Odessey', '1968-04-03', 'Scotland', 'Western Isles', 'Isle of Harris');
INSERT INTO MOVIE_LOCATION VALUES('The Princess Bride', '1987-09-25', 'Ireland', 'County Clare', 'Cliffs of Moher');
INSERT INTO MOVIE_LOCATION VALUES('Robin Hood: Men in Tights', '1993-07-28', 'USA', 'California', 'Santa Clarita');

/* MOVIE_SONG TABLE INSERT STATEMENTS */
INSERT INTO MOVIE_SONG VALUES('Star Wars: Episode IV', '1977-05-25', 'The Last Battle', '1977-05-05', 'John Williams');
INSERT INTO MOVIE_SONG VALUES('Star Wars: Episode V', '1980-05-21', 'The City in the Clouds', '1979-12-27', 'John Williams');
INSERT INTO MOVIE_SONG VALUES('Star Wars: Episode VI', '1983-05-25', 'Han Solo Returns', '1983-01-17', 'John Williams');
INSERT INTO MOVIE_SONG VALUES('The Lord of the Rings: The Fellowship of the Ring', '2001-12-19', 'A Knife in the Dark', '2001-11-20', 'Howard Shore');
INSERT INTO MOVIE_SONG VALUES('The Lord of the Rings: The Two Towers', '2002-12-18', 'Isengard Unleashed', '2002-12-10', 'Howard Shore');
INSERT INTO MOVIE_SONG VALUES('The Lord of the Rings: The Return of the King', '2003-12-17', 'Ash and Smoke', '2003-11-25', 'Howard Shore');
INSERT INTO MOVIE_SONG VALUES('2001: A Space Odessey', '1968-04-03', 'The Blue Danube', '1867-02-15', 'Johann Strauss II');
INSERT INTO MOVIE_SONG VALUES('The Princess Bride', '1987-09-25', 'The Swordfight', '1987-11-12', 'Mark Knopfler');
INSERT INTO MOVIE_SONG VALUES('Robin Hood: Men in Tights', '1993-07-28', 'Men in Tights', '1994-02-15', 'Mel Brooks');
INSERT INTO MOVIE_SONG VALUES('Caddyshack', '1980-07-25','Im Alright' ,'1980-07-07', 'Kenny Loggins');
INSERT INTO MOVIE_SONG VALUES('Ghostbusters', '1984-06-08', 'Ghostbusters', '1984-05-27', 'Ray Parker Jr');

/* SONG TABLE INSERT STATEMENTS */
INSERT INTO SONG VALUES('The Last Battle', 'John Williams', '1977-05-05', 'George Lucas', 'Star Wars: Original Motion Picture Soundtrack');
INSERT INTO SONG VALUES('The City in the Clouds', 'John Williams', '1979-12-27', 'John Williams', 'Star Wars: The Empire Strikes Back: Original Motion Picture Soundtrack');
INSERT INTO SONG VALUES('Han Solo Returns', 'John Williams', '1983-01-17', 'John Williams', 'Star Wars: Return of the Jedi: Original Motion Picture Soundtrack');
INSERT INTO SONG VALUES('A Knife in the Dark', 'Howard Shore', '2001-11-20', 'Howard Shore', 'The Lord of the Rings: The Fellowship of the Ring: Original Motion Picture Soundtrack');
INSERT INTO SONG VALUES('Isengard Unleashed', 'Howard Shore', '2002-12-10', 'Howard Shore', 'The Lord of the Rings: The Two Towers: Original Motion Picture Soundtrack');
INSERT INTO SONG VALUES('Ash and Smoke', 'Howard Shore', '2003-11-25', 'Howard Shore', 'The Lord of the Rings: The Return of the King: Original Motion Picture Soundtrack');
INSERT INTO SONG VALUES('The Blue Danube', 'Johann Strauss II', '1867-02-15', 'Joseph Weyl', '2001: A Space Odyssey (Soundtrack)');
INSERT INTO SONG VALUES('The Swordfight', 'Mark Knopfler',  '1987-11-12', 'Mark Knopfler', 'The Princess Bride (Soundtrack)');
INSERT INTO SONG VALUES('Men in Tights', 'Mel Brooks', '1994-02-15', 'Mel Brooks', 'Robin Hood: Men in Tights (Soundstrack)');
INSERT INTO SONG VALUES('Im Alright' ,'Kenny Loggins' , '1980-07-07', 'Kenny Loggins', 'Caddyshack: Music from the Motion Picture Soundtrack');
INSERT INTO SONG VALUES('Ghostbusters', 'Ray Parker Jr', '1984-05-27', 'Ray Parker Jr', 'Ghostbusters (Soundtrack)');


/* Enable foreign key constraints - keep here */
PRAGMA foreign_keys=1;


/*
**************************************
* 			SAM'S QUERIES
**************************************

1. Select all movies not prodcued by the producer of Star Wars

2. Select all movies released in 2001

3. Select all movies shot in the USA released between 1970 and 2000

4. Select all movies by the writer and director of Lord of the Rings

5. Select the average length of movies' directed by the director of the first Lord of the Rings movie

6. Select the artist and the album of every song in any of the Star Wars movies

7. Select the country, region, place, of all movies written by a screenwriter who has been active since 1980

8. Select the first and last name of all actors who have not acted in a movie in the database

9. Select the first and last name of all actors who have acted in a movie which was directed by a director who has been active since 1980

*/

.print "\nSelect all movies not prodcued by the producer of Star Wars:\n"
SELECT m_title AS 'Movie' 
FROM MOVIE 
WHERE m_producer 
NOT IN(SELECT m_producer 
       FROM MOVIE 
       WHERE m_title LIKE('%Star Wars%'));


.print "\nSelect all movies released in 2001:\n"
SELECT m_title AS 'Movie' 
FROM MOVIE 
WHERE m_release_date LIKE('2001%');


.print "\nSelect all movies shot in the USA released between 1970 and 2000:\n"
SELECT movie AS 'Movie' 
FROM MOVIE_LOCATION 
WHERE country = 'USA' AND movie IN(SELECT m_title 
								   FROM MOVIE 
								   WHERE m_release_date > '1970-01-01' AND m_release_date < '2000-01-01');


.print "\nSelect all movies by the writer and director of Lord of the Rings:\n"
SELECT m_title AS 'Movie' 
FROM MOVIE, WRITTEN_BY
WHERE m_director IN(SELECT m_director 
				    FROM MOVIE 
				    WHERE m_title LIKE('%Lord of the Rings%')) 
AND writer IN(SELECT writer 
			  FROM WRITTEN_BY 
			  WHERE movie LIKE('%Lord of the Rings%')) 
GROUP BY m_title;


.print "\nSelect the average length of movies' directed by the director of the first Lord of the Rings movie:\n"
SELECT AVG(minutes) AS 'Average Length' 
FROM MOVIE 
WHERE m_director IN (SELECT m_director 
					 FROM MOVIE 
					 WHERE m_title = 'The Lord of the Rings: The Fellowship of the Ring');


.print "\nSelect the artist and the album of every song in any of the Star Wars movies:\n"
SELECT song AS 'Song', s_artist AS 'Artist', album AS 'Album'
FROM MOVIE_SONG, SONG 
WHERE s_title = song AND movie LIKE('%Star Wars%');


.print "\nSelect the country, region, place, of all movies written by a screenwriter who has been active since 1980:\n"
SELECT country AS 'Country', place AS 'Place', region AS 'Region'
FROM MOVIE_LOCATION L 
WHERE L.movie IN(SELECT movie 
				 FROM WRITTEN_BY W 
				 WHERE writer IN (SELECT w_ID 
				 				  FROM SCREENWRITER 
				 				  WHERE w_active_from >= ('1980-01-01')));


.print "\nSelect the first and last name of all actors who have not acted in a movie in the database:\n"
SELECT a_fname AS 'First Name', a_lname AS 'Last Name' 
FROM ACTOR 
WHERE a_ID NOT IN(SELECT actor 
	              FROM ACTED_IN);



.print "\nSelect the first and last name of all actors who have acted in a movie which was\ndirected by a director who has been active since 1980:\n"
SELECT a_fname AS 'First Name', a_lname AS 'Last Name'
FROM ACTOR 
WHERE a_ID IN(SELECT actor 
			  FROM ACTED_IN 
			  WHERE movie IN(SELECT m_title 
			  				 FROM MOVIE 
			  				 WHERE m_director IN(SELECT d_ID 
			  				 					 FROM DIRECTOR 
			  				 					 WHERE d_active_from <= '1980-12-31')));




/*
**************************************
* 		       STEVE'S QUERIES
**************************************

1. Select all of the info for each movie where the genre is “Fantasy”, ordered by release date

2. Select the first and last name of each director who has directed more than one movie, as well as a count for the number of movies they have directed

3. Select the unique genres in the database and a count of how many movies are in that genre, arranged in reverse alphabetical order according to genre

4. Select first and last name for every screenwriter who worked on a Lord of the Rings movie, ordered by last name first, then first name

5. Select first and last name and birthdate for every Actor in ascending order according to birthdate

*/

.print "\nSelect all of the info for each movie where the genre is 'Fantasy', ordered by release date:\n"
SELECT * 
FROM MOVIE 
WHERE genre = 'Fantasy' 
ORDER BY m_release_date;

.print "\nSelect the first and last name of each director who has directed more than one movie, as well as a count for the number of movies they have directed:\n"
SELECT d_fname AS 'First Name', d_lname AS 'Last Name', COUNT(m_director) AS '# of Movies'
FROM DIRECTOR, MOVIE 
WHERE d_ID = m_director AND d_ID IN (SELECT m_director 
									 FROM MOVIE 
									 GROUP BY m_director 
									 HAVING COUNT(m_director) > 1) 
GROUP BY m_director;

.print "\nSelect the unique genres in the database and a count of how many movies are in that genre, arranged in reverse alphabetical order according to genre:\n"
SELECT genre AS 'Genre', COUNT(m_title) AS '# of Movies'
FROM MOVIE
GROUP BY genre
ORDER BY genre DESC;

.print "\nSelect first and last name for every screenwriter who worked on a Lord of the Rings movie, ordered by last name first, then first name:\n"
SELECT w_fname AS 'First Name', w_lname AS 'Last Name'
FROM SCREENWRITER, WRITTEN_BY
WHERE w_ID = writer AND movie LIKE('%Lord of the Rings%')
GROUP BY w_ID
ORDER BY w_lname, w_fname;

.print "\nSelect first and last name and birthdate for every Actor in ascending order according to birthdate:\n"
SELECT a_fname AS 'First Name', a_lname AS 'Last Name', a_DOB AS 'Date of Birth'
FROM ACTOR
ORDER BY a_DOB;

/*
**************************************
* 		     MICHAEL'S QUERIES
**************************************

1. Select all movies that Brad Pitt acted in, in alphabetical order by movie title

2. Select all of the Lord of the Rings films and their repsective locations, order by ascending movie release date

3. Select the average length of all movies (in minutes)

4. Select the movie name, director's name, and length of the longest movie

5. Select the count of Star Wars films and the total length of all the Star Wars films (in minutes)

6. Select the number of actors from each nationality

*/

.print "\nSelect all movies that Brad Pitt acted in, in alphabetical order by movie title:\n"
SELECT movie AS 'Movie'
FROM ACTED_IN
WHERE actor IN(
		SELECT a_ID 
		FROM ACTOR
		WHERE a_fname = 'Brad' AND a_lname = 'Pitt' AND a_DOB = '1963-12-18')
ORDER BY movie;

.print "\nSelect all of the Lord of the Rings films and their repsective locations, order by ascending movie release date:\n"
SELECT movie AS 'Movie', place AS 'Place', region AS 'Region', country AS 'Country'
FROM MOVIE_LOCATION
WHERE movie LIKE('%Lord of the Rings%')
ORDER BY movie_release;

.print "\nSelect the average length of all movies (in minutes)\n"
SELECT avg(minutes) AS 'Average Length in Minutes'
FROM MOVIE;

.print "\nSelect the movie name, director's name, and length of the longest movie\n"
SELECT m_title AS 'Movie', d_fname AS 'First', d_lname AS 'Last', minutes AS 'Minutes'
FROM MOVIE, DIRECTOR 
WHERE d_ID = m_director AND minutes IN(
					SELECT max(minutes)
					FROM MOVIE);
					
.print "\nSelect the count of Star Wars films and the total length of all the Star Wars films (in minutes):\n"
SELECT count(*) AS 'Count', sum(minutes) AS 'Total Length'
FROM MOVIE
WHERE m_title LIKE('%Star Wars%');

.print "\nSelect the number of actors from each nationality:\n"
SELECT a_nationality AS 'Nationality', count(*) AS 'Count'
FROM ACTOR
GROUP BY a_nationality;

/*
**************************************
* 		   HUNTER'S QUERIES
**************************************

1. Select the count of all MOVIE_SONGs where the artist is 'John Williams' from Star Wars 

2. Select all song release dates of SONGs from MOVIES released before 1980 and the associated movie release date sort by SONG release date

3. Select all MOVIEs where there SONG with the word 'Swordfight' in the title

4. Select all MOVIEs that 'Kenny Loggins' wrote SONGs for 

5. Select all SONGs from any of the Star Wars movies released after 1980

*/

.print "\nSelect the count of all MOVIE_SONGs where the artist is 'John Williams' from Star Wars:\n"
SELECT COUNT(*) AS 'Count'
FROM MOVIE_SONG
WHERE artist = 'John Williams' AND movie LIKE('%Star Wars%');

.print "\nSelect all songs and song release dates of SONGs from MOVIES released before 1980 and the associated movie release date sort by SONG release date:\n"
SELECT song AS 'Song', song_release AS 'Song Release', m_release_date AS 'Movie Release'
FROM MOVIE, MOVIE_SONG
WHERE movie = m_title AND m_release_date <= ('1980-01-01')
ORDER BY song_release;

.print "\nSelect all MOVIEs where there SONG with the word 'Swordfight' in the title:\n"
SELECT m_title AS 'Movie'
FROM MOVIE, MOVIE_SONG
WHERE movie = m_title AND song LIKE '%Swordfight%';

.print "\nSelect all MOVIEs that 'Kenny Loggins' wrote SONGs for:\n"
SELECT m_title AS 'Movie'
FROM MOVIE, MOVIE_SONG
WHERE movie = m_title AND artist = 'Kenny Loggins';

.print "\nSelect all SONGs from any of the Star Wars movies released after 1980 in descending order:\n"
SELECT song AS 'Song'
FROM MOVIE, MOVIE_SONG
WHERE movie = m_title AND movie LIKE '%Star Wars%' AND m_release_date >= ('1981-01-01')
ORDER BY song_release DESC;


/*
**************************************
* 		     ANDREW'S QUERIES
**************************************

1. Directors active before 1975-01-01

2. Directors who have directed more than one movie

3. Actors who have appeared in a movie which genre is 'Fantasy' and have been released after 1980-01-01 ordered by amount of movies they have appeared in

4. Directors who are the same nationality as actor 'Bill' 'Murray'

5. Directors who have directed a movie which genre is 'Fantasy'

*/

.print "\nDirectors active before 1975-01-01:\n" 	
SELECT d_fname AS 'First', d_lname AS 'Last'
FROM DIRECTOR 
WHERE d_active_from < '1975-01-01';

.print "\nDirectors and the count of movies they have directed who have directed more than one movie:\n"
SELECT d_fname AS 'First', d_lname AS 'Last', COUNT(MOVIE.m_director) AS 'Count'
FROM DIRECTOR, MOVIE 
WHERE DIRECTOR.d_ID = MOVIE.m_director 
GROUP BY d_ID 
HAVING COUNT(MOVIE.m_director) > 1;

.print "\nActors and the amount of movies they have appeared in who have appeared in a movie which genre\nis 'Fantasy' and have been released after 1980-01-01 ordered by amount of \nmovies they have appeared in:\n"
SELECT a_fname AS 'First', a_lname AS 'Last', COUNT(acted_in.actor) AS 'Count'
FROM ACTOR, ACTED_IN, MOVIE 
WHERE ACTOR.a_ID = ACTED_IN.actor AND MOVIE.m_title = ACTED_IN.movie AND MOVIE.m_release_date = ACTED_IN.movie_release AND MOVIE.genre = 'Fantasy' AND MOVIE.m_release_date > '1980%' 
GROUP BY ACTOR.a_fname 
ORDER BY COUNT(ACTED_IN.movie);
	
.print "\nDirectors who are the same nationality as actor 'Bill' 'Murray':\n"
SELECT d_fname AS 'First', d_lname AS 'Last'
FROM DIRECTOR 
WHERE d_nationality =(SELECT a_nationality 
					  FROM ACTOR 
					  WHERE a_fname = 'Bill' AND a_lname = 'Murray');
		
.print "\nDirectors who have directed a movie which genre is 'Fantasy':\n"
SELECT d_fname AS 'First',d_lname AS 'Last'
FROM DIRECTOR, MOVIE 
WHERE DIRECTOR.d_ID = MOVIE.m_director AND MOVIE.genre = 'Fantasy' 
GROUP BY d_fname,d_lname;






