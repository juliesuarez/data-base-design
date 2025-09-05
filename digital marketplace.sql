-- Question 1: Build a Complete Database Management System
-- About the Project
-- It's a marketplace because of its core function of connecting players and clubs
-- For Football Players: Aspiring players can sign up for free, create a detailed profile with their stats (position, country, etc.), 
-- and upload videos of their skills, goals, and match highlights. 
-- This gives them a professional online portfolio to showcase their abilities.
-- For Clubs & Scouts: Clubs and scouts can register and subscribe to the platform to gain access to a growing database of talent. 
-- They can search for players, view their detailed profiles, and watch their performance videos.
-- create the database to use
CREATE DATABASE talenthub_db;

-- tell the engine which database to use
USE talenthub_db;

-- create tables in the datable that will store the data
-- This is the base table for all users
CREATE TABLE customusers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    password VARCHAR(128) NOT NULL,
    last_login DATETIME(6),
    username VARCHAR(150) NOT NULL UNIQUE,
    first_name VARCHAR(150) NOT NULL,
    last_name VARCHAR(150) NOT NULL,
    email VARCHAR(254) NOT NULL,
    is_superuser TINYINT(1) NOT NULL DEFAULT 0, 
    is_staff TINYINT(1) NOT NULL DEFAULT 0,     
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    date_joined DATETIME(6)  NULL,
    user_type ENUM('player', 'club') NOT NULL
);

-- create table to store the player's information
-- tores extra details for users who are players.
CREATE TABLE players (
    user_id INT PRIMARY KEY,
    country VARCHAR(100) NOT NULL,
    position VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    bio TEXT,
    -- RELATIONSHIP: ONE-TO-ONE to customuser
    -- The FOREIGN KEY is also the PRIMARY KEY, ensuring each user can have only one player profile.
    FOREIGN KEY (user_id) REFERENCES customusers(id) ON DELETE CASCADE
);

-- Stores extra details for users who are clubs
CREATE TABLE clubs (
    user_id INT PRIMARY KEY,
    club_name VARCHAR(200) NOT NULL,
    country VARCHAR(100) NOT NULL,
    description TEXT,
    -- RELATIONSHIP: ONE-TO-ONE to core_customuser.
    -- The FOREIGN KEY is also the PRIMARY KEY, ensuring each user can have only one club profile.
    FOREIGN KEY (user_id) REFERENCES customusers(id) ON DELETE CASCADE
);

-- Tracks the subscription status for each club
CREATE TABLE subscriptions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    club_id INT NOT NULL UNIQUE,
    tier VARCHAR(10) NOT NULL DEFAULT 'free',
    start_date DATETIME(6) NULL,
    end_date DATETIME(6),
    is_active TINYINT(1) NOT NULL DEFAULT 0,
    -- RELATIONSHIP: ONE-TO-ONE to core_clubprofile.
    -- The UNIQUE constraint on club_id ensures each club can have only one subscription.
    FOREIGN KEY (club_id) REFERENCES clubs(user_id) ON DELETE CASCADE
);

-- Stores information about uploaded videos
CREATE TABLE videos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    video_file VARCHAR(100) NOT NULL, 
    uploaded_at DATETIME(6) NULL,
    FOREIGN KEY (player_id) REFERENCES players(user_id) ON DELETE CASCADE
);

-- Stores the AI-generated tags for each video
CREATE TABLE videotags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    video_id INT NOT NULL,
    tag VARCHAR(100) NOT NULL,
    start_time DOUBLE NULL,
    end_time DOUBLE NOT NULL,
    FOREIGN KEY (video_id) REFERENCES videos(id) ON DELETE CASCADE
);

CREATE TABLE clubshortlists (
    club_id INT,
    player_id INT,
    date_added DATETIME(6) NULL,
    
    -- RELATIONSHIP: MANY-TO-MANY between club and player.
    -- A club can shortlist many players, and a player can be shortlisted by many clubs
    FOREIGN KEY (club_id) REFERENCES clubs(user_id) ON DELETE CASCADE,
    FOREIGN KEY (player_id) REFERENCES players(user_id) ON DELETE CASCADE,
    
    -- This composite primary key ensures a club can't shortlist the same player twice
    PRIMARY KEY (club_id, player_id)
);

-- create users into the table 
INSERT INTO customusers (username, password, first_name, last_name, email, user_type) VALUES
('jokello', '123', 'John', 'Okello', 'j.okello@gmail.com', 'player'),
('domondi', '1234', 'David', 'Omondi', 'd.omondi@gmail.com', 'player'),
('ajuma', '12345', 'Aisha', 'Juma', 'a.juma@egmail.com', 'player'),
('pwasswa', '12346', 'Peter', 'Wasswa', 'p.wasswa@gmail.com', 'player'),
('mwanjiku', '1234567', 'Mary', 'Wanjiku', 'm.wanjiku@gmail.com', 'player'),
('hmwakinyo', '123', 'Hassan', 'Mwakinyo', 'h.mwakinyo@gmail.com', 'player'),
('snabirye', '123', 'Sandra', 'Nabirye', 's.nabirye@gmail.com', 'player'),
('kccafc', '123', 'KCCA', 'FC', 'scout@kcca.co.ug', 'club'),
('simbasc', '123', 'Simba', 'SC', 'scout@simbasc.co.tz', 'club'),
('gormahia', '123', 'Gor', 'Mahia', 'scout@gormahia.co.ke', 'club');

-- retrieve users
SELECT * FROM customusers;

-- create players
INSERT INTO players (user_id, country, position, date_of_birth, bio) VALUES
(1, 'Uganda', 'Striker', '2004-05-15', 'A fast and clinical striker with a powerful shot.'),
(2, 'Kenya', 'Midfielder', '2003-09-22', 'Creative attacking midfielder with excellent vision and passing.'),
(3, 'Tanzania', 'Defender', '2004-01-30', 'A strong central defender, dominant in the air.'),
(4, 'Uganda', 'Goalkeeper', '2002-11-10', 'Agile goalkeeper with great reflexes and distribution skills.'),
(5, 'Kenya', 'Winger', '2005-03-25', 'Speedy winger who loves to take on defenders.'),
(6, 'Tanzania', 'Midfielder', '2003-07-18', 'Box-to-box midfielder with a high work rate.'),
(7, 'Uganda', 'Defender', '2004-08-05', 'Versatile defender who can play as a full-back or center-back.');

-- retrieve players
SELECT * FROM players;

-- create clubs
INSERT INTO clubs (user_id, club_name, country, description) VALUES
(8, 'KCCA FC', 'Uganda', 'Kampala Capital City Authority Football Club, a top-tier club in the Uganda Premier League.'),
(9, 'Simba SC', 'Tanzania', 'One of the most successful football clubs in Tanzania, based in Dar es Salaam.'),
(10, 'Gor Mahia F.C.', 'Kenya', 'A historic and successful football club based in Nairobi, Kenya.');

-- retrieve clubs
SELECT * FROM clubs;

-- create subscriptions
INSERT INTO subscriptions (club_id, tier, end_date, is_active) VALUES
(8, 'pro', '2026-09-01 00:00:00', 1), -- KCCA FC has an active pro subscription
(9, 'pro', '2026-09-01 00:00:00', 1), -- Simba SC has an active pro subscription
(10, 'free', NULL, 1); 

-- retrieve subscriptions 
SELECT * FROM subscriptions;

-- cerate videos
INSERT INTO videos (player_id, title, video_file) VALUES
(1, 'John Okello - Best Goals 2025', 'videos/jokello_goals.mp4'),
(1, 'John Okello - Dribbling Skills', 'videos/jokello_skills.mp4'),
(2, 'David Omondi - Passing Compilation', 'videos/domondi_passing.mp4'),
(3, 'Aisha Juma - Defensive Masterclass', 'videos/ajuma_defense.mp4'),
(4, 'Peter Wasswa - Top Saves', 'videos/pwasswa_saves.mp4'),
(5, 'Mary Wanjiku - Speed and Crosses', 'videos/mwanjiku_wingplay.mp4'),
(6, 'Hassan Mwakinyo - Midfield Dominance', 'videos/hmwakinyo_midfield.mp4'),
(7, 'Sandra Nabirye - Tackling Highlights', 'videos/snabirye_tackles.mp4');

-- retrieve videos
SELECT * FROM videos;

-- create video tags
INSERT INTO videotags (video_id, tag, start_time, end_time) VALUES
(1, 'Goal', 15.5, 18.2),
(1, 'Shot', 45.1, 46.0),
(2, 'Dribble', 22.0, 28.5),
(3, 'Tackle', 10.2, 11.5),
(3, 'Header', 55.8, 57.1),
(4, 'Save', 30.5, 33.0),
(4, 'Save', 75.2, 78.9),
(5, 'Cross', 18.3, 20.1),
(6, 'Pass', 63.0, 64.5),
(7, 'Tackle', 12.0, 13.0);









