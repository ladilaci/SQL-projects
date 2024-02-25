CREATE DATABASE f1_project;
USE f1_project;

-- CREATING THE TABLES ONE BY ONE

CREATE TABLE qualifying(qualifyId INT PRIMARY KEY,
	raceId INT,
	driverId INT,
	constructorId INT,
	number INT,
	position INT,
	q1 TIME(3),
	q2 TIME(3),
	q3 TIME(3),
    FOREIGN KEY (raceId) REFERENCES races(raceId)
);

DESC qualifying;

CREATE TABLE races(raceId INT PRIMARY KEY,
	year_ YEAR,
	round INT,
	circuitId INT,
	name_ VARCHAR (250),
	date_ DATE,
	time_ TIME,
    url VARCHAR (250),
	fp1_date DATE,
	fp1_time TIME,
	fp2_date DATE,
	fp2_time TIME,
	fp3_date DATE,
	fp3_time TIME,
	quali_date DATE,
	quali_time TIME,
	sprint_date DATE,
	sprint_time TIME
);

DESC races;

CREATE TABLE results(resultId INT PRIMARY KEY,
	raceId INT,
	driverId INT,
	constructorId INT,
	number INT,
	grid INT,
	position INT,
	positionText INT,
	positionOrder INT,
	points INT,
	laps INT,
	time VARCHAR(20),
	milliseconds INT,
	fastestLap INT,
    rank_ INT,
    fastestLapTime VARCHAR(20),
	fastestLapSpeed INT,
	statusId INT,
    FOREIGN KEY (raceId) REFERENCES races(raceId),
    FOREIGN KEY (driverId) REFERENCES drivers(driverId)
);

CREATE TABLE seasons(year INT,
	URL VARCHAR (150)
);

DESC seasons;

CREATE TABLE sprint_results(resultId INT,
	raceId INT,
	driverId INT,
	constructorId INT,
	number INT,
	grid INT,
	position INT,
	positionText VARCHAR(10),
	positionOrder INT,
	points INT,
	laps INT,
	time VARCHAR(10),
	milliseconds INT,
	fastestLap INT,
	fastestLapTime VARCHAR(10),
	statusId INT,
    FOREIGN KEY (raceId) REFERENCES races(raceId),
    FOREIGN KEY (driverId) REFERENCES drivers(driverId)
);

CREATE TABLE status(statusId INT PRIMARY KEY,
	status VARCHAR (150)
);

CREATE TABLE circuits(circuitId INT PRIMARY KEY,
	circuitRef VARCHAR (150),
	name VARCHAR (150),
	location VARCHAR (150),
	country VARCHAR (150),
	lat INT,
	lng INT,
	alt INT
);

CREATE TABLE constructor_results(constructorResultsId INT PRIMARY KEY,
	raceId INT,
	constructorId INT,
	points INT,
    FOREIGN KEY (raceId) REFERENCES races(raceId),
    FOREIGN KEY (constructorId) REFERENCES constructors(constructorId)
);

CREATE TABLE constructor_standings(constructorStandingsId INT,
	raceId INT,
	constructorId INT,
	points INT,
	position INT,
	positionText INT,
	wins INT,
    FOREIGN KEY (raceId) REFERENCES races(raceId),
    FOREIGN KEY (constructorId) REFERENCES constructors(constructorId)
);

CREATE TABLE constructors(constructorId INT PRIMARY KEY,
	constructorRef VARCHAR(150),
	name VARCHAR(150),
	nationality VARCHAR(150)
);

CREATE TABLE driver_standings(driverStandingsId INT PRIMARY KEY,
	raceId INT,
	driverId INT,
	points INT,
	position INT,
	positionText INT,
	wins INT,
    FOREIGN KEY (raceId) REFERENCES races(raceId),
    FOREIGN KEY (driverId) REFERENCES drivers(driverId)
);

CREATE TABLE drivers(driverId INT PRIMARY KEY,
	driverRef VARCHAR (250),
	number INT,
	code VARCHAR (250),
	forename VARCHAR (250),
	surname VARCHAR (250),
	dob DATE,
	nationality VARCHAR (250)
);

DESC drivers;

CREATE TABLE lap_times(raceId INT,
	driverId INT,
	lap INT,
	position INT,
	time VARCHAR(10),
	milliseconds INT,
    FOREIGN KEY (raceId) REFERENCES races(raceId),
    FOREIGN KEY (driverId) REFERENCES drivers(driverId)
);

CREATE TABLE pit_stops(raceId INT,
	driverId INT,
	stop INT,
	lap INT,
	time TIME,
	duration DECIMAL(5, 3),
	milliseconds INT,
    FOREIGN KEY (raceId) REFERENCES races(raceId),
    FOREIGN KEY (driverId) REFERENCES drivers(driverId)
);

CREATE TABLE status(statusId INT,
	status VARCHAR(250)
);

SET GLOBAL local_infile=1;

SHOW GLOBAL VARIABLES LIKE 'local_infile';

-- IMPORTING DATA TO THE TABLES FROM .CSV FILES

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/qualifying.csv'
    INTO TABLE qualifying
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;
    
SELECT * FROM qualifying;

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/races.csv'
INTO TABLE races
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
    
SELECT * FROM races;

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/results.csv'
    INTO TABLE results
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

SELECT * FROM results;

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/seasons.csv'
    INTO TABLE seasons
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;
    
SELECT * FROM seasons;

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sprint_results.csv'
    INTO TABLE sprint_results
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;
    
SELECT * FROM sprint_results;

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/circuits.csv'
    INTO TABLE circuits
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;
    
SELECT * FROM circuits;

ALTER TABLE circuits
MODIFY COLUMN lat DECIMAL(6, 4);

ALTER TABLE circuits
MODIFY COLUMN lng DECIMAL(8, 4);

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/constructor_results.csv'
    INTO TABLE constructor_results
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

SELECT * FROM constructor_results;

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/constructor_standings.csv'
    INTO TABLE constructor_standings
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;
    
SELECT * FROM constructor_standings;

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/constructors.csv'
    INTO TABLE constructors
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

SELECT * FROM constructors;

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/driver_standings.csv'
    INTO TABLE driver_standings
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

SELECT * FROM driver_standings;

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/drivers.csv'
    INTO TABLE drivers
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

SELECT * FROM drivers;

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/lap_times.csv'
    INTO TABLE lap_times
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

SELECT * FROM lap_times;

SELECT COUNT(*) FROM lap_times;

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/pit_stops.csv'
    INTO TABLE pit_stops
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

SELECT * FROM pit_stops;

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/status.csv'
    INTO TABLE status
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;
    
SELECT * FROM status;

-- QUERIES

-- Which race tracks are situated at the highest altitude above sea level and where is it(location)? (circuits)

SELECT name, location FROM circuits
	ORDER BY alt DESC
    LIMIT 5;

-- Which race track is situated at the lowest altitude above sea level and where is it(location)? (circuits)

SELECT name, location FROM circuits
	ORDER BY alt
    LIMIT 5;

-- Which country has produced the most constructors? (constructors)

SELECT nationality
FROM constructors
GROUP BY nationality
ORDER BY COUNT(*) DESC
LIMIT 3;

-- Which nation has produced the most podium-finishing drivers? (drivers, results)

SELECT nationality
FROM drivers
JOIN results ON drivers.driverId = results.driverId
WHERE position <= 3
GROUP BY nationality
ORDER BY COUNT(*) DESC
LIMIT 3;

-- Which constructors have scored the most points so far? (constructors, constructor_results)

SELECT name
FROM constructors
JOIN constructor_results ON constructors.constructorId = constructor_results.constructorId
GROUP BY name
ORDER BY SUM(constructor_results.points) DESC
LIMIT 3;

-- Which constructor has the most victories? (constructor_results, results)

SELECT name
FROM constructors
JOIN constructor_results ON constructors.constructorId = constructor_results.constructorId
JOIN results ON constructors.constructorId = results.constructorId
WHERE position = 1
GROUP BY name
ORDER BY COUNT(*) DESC
LIMIT 3;

-- Which drivers have finished on the podium after starting from positions beyond 10th place? (driver_standings)

SELECT CONCAT(forename, " ", surname)
FROM drivers
JOIN results ON drivers.driverId = results.driverId
WHERE position <= 3 AND grid > 10;

-- Which racetrack witnessed the fastest lap and who set it? (lap_times)

SELECT name_, CONCAT(forename, " ", surname) AS driver_name, time
FROM races
JOIN lap_times ON races.raceId = lap_times.raceId
JOIN drivers ON lap_times.driverId = drivers.driverId
WHERE lap_times.time = (
    SELECT MIN(time)
    FROM lap_times
);

-- Who holds the record for the fastest pit stop in Formula 1 so far and with which constructor? (pit_stops) *

SELECT CONCAT(forename, ' ', surname) AS driver_name, milliseconds
FROM pit_stops
JOIN races ON pit_stops.raceId = races.raceId
JOIN drivers ON pit_stops.driverId = drivers.driverId
JOIN constructors ON drivers.driverId = constructors.constructorId
WHERE pit_stops.milliseconds = (
    SELECT MIN(milliseconds)
    FROM pit_stops
);

-- Who has achieved the most pole positions and with which constructor? (qualifying)

SELECT CONCAT(forename, ' ', surname) AS driver_name, COUNT(*) AS pole_positions
FROM qualifying
JOIN drivers ON qualifying.driverId = drivers.driverId
WHERE position = 1
GROUP BY drivers.driverId
ORDER BY position DESC
LIMIT 3;

-- Who has set the fastest qualifying time so far and where? (qualifying)*

SELECT CONCAT(forename, ' ', surname) AS driver_name, q3
FROM qualifying
JOIN races ON qualifying.raceId = races.raceId
JOIN drivers ON qualifying.driverId = drivers.driverId
WHERE q3 != '00:00:00.000'
AND q3 = (
    SELECT MIN(q3)
    FROM qualifying
);

-- Where have the most Formula 1 races been held so far? (races)

SELECT name, COUNT(*) AS race_count
FROM circuits
JOIN races ON circuits.circuitId = races.circuitId
GROUP BY name
ORDER BY race_count DESC
LIMIT 3;

-- In which position has the fastest lap been achieved the most times so far? (results)

SELECT lap, COUNT(*) AS lap_count
FROM lap_times
WHERE time = (
    SELECT MIN(time)
    FROM lap_times
)
GROUP BY lap
ORDER BY lap_count DESC
LIMIT 3;

-- Which Formula 1 driver was born earliest? (drivers)

SELECT CONCAT(forename, ' ', surname) AS driver_name, dob
FROM drivers
ORDER BY dob
LIMIT 1;

-- Which country has produced the most Formula 1 drivers? (drivers)

SELECT nationality, COUNT(*) AS driver_count
FROM drivers
GROUP BY nationality
ORDER BY driver_count DESC
LIMIT 1;

-- How many Formula 1 races have been held so far? (races)

SELECT circuits.name, COUNT(*) AS race_count
FROM races
JOIN circuits ON races.circuitId = circuits.circuitId
GROUP BY circuits.circuitId, circuits.name
ORDER BY race_count DESC
LIMIT 1;

-- When was there no Formula 1 season held? (seasons)

SELECT DISTINCT year
FROM races
WHERE year NOT IN (
    SELECT DISTINCT year
    FROM races
    WHERE year < 1950
);






