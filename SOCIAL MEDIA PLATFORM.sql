
-- PROJECT NAME: SOCIAL MEDIA PLATFORM(like instagram/Twitter)--

CREATE DATABASE IF NOT EXISTS socialmedia_db;
USE socialmedia_db;

CREATE TABLE users(
user_id INT AUTO_INCREMENT PRIMARY KEY,
user_name VARCHAR(50) NOT NULL UNIQUE,
email VARCHAR(100) NOT NULL UNIQUE,
full_name VARCHAR(100) NOT NULL,
dob DATE
);

CREATE TABLE posts(
post_id INT AUTO_INCREMENT PRIMARY KEY,
user_id INT,
caption TEXT,
posted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY(user_id) REFERENCES users(user_id)
);

CREATE TABLE followers(
follower_id INT,
following_id INT,
follow_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY(follower_id, following_id),
FOREIGN KEY(follower_id) REFERENCES users(user_id),
FOREIGN KEY(following_id) REFERENCES users(user_id)
);

INSERT INTO users(user_name,email,full_name,dob)
VALUES
('aarav01','aarav@gmail.com','Aarav Sharma','1998-03-12'),
('aisha02','aisha@yahoo.com','Aisha Khan','2000-07-21'),
('rohan03','rohan@hotmail.com','Rohan Das','1997-11-05'),
('neel04','neel@gmail.com','Neel Patel','1999-01-30'),
('tanya05','tanya@email.com','Tanya Mehta','2001-06-18'),
('vikram06','vikram@gmail.com','Vikram Singh','1995-09-25'),
('pooja07','pooja@yahoo.com','Pooja Nair','1996-12-10'),
('karan08','karan@hotmail.com','Karan Verma','1994-04-08'),
('divya09','divya@gmail.com','Divya Iyer','2002-02-14'),
('manoj10','manoj@email.com','Manoj Kumar','1993-08-19');

INSERT INTO posts (user_id, caption, posted_at) VALUES
(1, 'Morning walk with fresh vibes', '2024-01-10'),
(2, 'Trying a new cafe today', '2024-03-15'),
(3, NULL, '2024-05-20'),
(4, 'Learning SQL step by step', '2024-07-05'),
(5, 'Beach day with friends', '2023-12-28'),
(6, 'Workout completed ', '2024-09-09'),
(7, NULL, '2024-10-12'),
(8, 'Movie night ', '2024-11-18'),
(9, 'Exploring new places', '2024-06-25'),
(10, NULL, '2024-02-14');

INSERT INTO followers(follower_id, following_id, follow_date)
VALUES
(1,2,'2024-01-01'),
(2,3,'2024-02-10'),
(3,4,'2024-03-15'),
(4,5,'2024-04-20'),
(5,6,'2024-05-25'),
(6,1,'2024-06-30'),
(7,2,'2024-07-10'),
(8,3,'2024-08-05'),
(9,4,'2024-09-12'),
(10,5,'2024-10-01');

/*---------------------------------------------------------------------------------------------------------------------------
 DISTINCT, WHERE, IN, BETWEEN, NULL checks 
 ---------------------------------------------------------------------------------------------------------------------------*/
/*--------- Retrieve all users whose username starts with “a” -------------*/
select * from users;
select distinct * from users where user_name like "a%";

/*-------- Get posts posted BETWEEN '2024-01-01' AND '2024-12-31' ---------*/
select * from posts;
select * from posts where posted_at between '2024-01-01' AND '2024-12-31';

/*-------- Find posts that have NULL captions ------------------------------*/
select * from posts where caption is null;

/*-------- Find users whose email domain is in: (@gmail.com, @hotmail.com, @yahoo.com) --------*/
select * from users where substring_index(email,'@',-1) in ('gmail.com', 'hotmail.com', 'yahoo.com');

/*---------------------------------------------------------------------------------------------------------------------------
 Order by, Group by, Limit, Having 
 ---------------------------------------------------------------------------------------------------------------------------*/
 /*Challenge 1 — Top Active Users Sort users by number of posts (DESC) and LIMIT 5.*/
 select * from users;
 select * from posts;
 
 select user_id, count(*) as active_users from posts
 group by user_id
 order by user_id desc
 limit 5;
 /*Challenge 2 — Group by Posts Per Day Group posts by DATE(posted_at) and return:
date total posts Only show days with more than 10 posts (HAVING).*/
 select * from posts;
 
 SELECT DATE(posted_at) Posted_On, DAYNAME(posted_at) Posted_day ,COUNT(*) AS Total_Posts FROM posts
GROUP BY Posted_On, Posted_day
HAVING Total_Posts > 10;

/*---------------------------------------------------------------------------------------------------------------------------
JOINS, UNION, BUILT-IN FUNCTIONS
 ---------------------------------------------------------------------------------------------------------------------------*/
/*Challenge 1 — Comments Table
Create:comments - comment_id (PK),post_id (FK),user_id (FK),comment_text,commented_at
-- likes Table
like_id (PK),post_id (FK),user_id (FK),liked_at */

CREATE TABLE IF NOT exists comments(
comment_id INT PRIMARY KEY AUTO_INCREMENT,
post_id INT,
user_id INT,
comment_text TEXT,
commented_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY(post_id) REFERENCES posts(post_id),
FOREIGN KEY(user_id) REFERENCES users(user_id));
SELECT * FROM posts;
SELECT * FROM comments;

CREATE TABLE likes(
like_id INT AUTO_INCREMENT PRIMARY KEY,
post_id INT,
user_id INT,
liked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY(post_id) REFERENCES posts(post_id),
FOREIGN KEY(user_id) REFERENCES users(user_id));

INSERT INTO comments (Post_id, User_id, Comment_text, Commented_at) VALUES
(1,2,'Beautiful capture!','2024-02-01 09:10:20'),
(2,3,'Looks amazing!','2024-02-02 10:25:35'),
(3,4,'Really inspiring post','2024-02-03 08:45:50'),
(4,5,'Loved this content','2024-02-04 14:15:10'),
(5,6,'So helpful, thanks!','2024-02-05 16:40:25'),
(6,7,'Interesting thoughts','2024-02-06 07:55:30'),
(7,8,'Nice one ','2024-02-07 11:20:45'),
(8,9,'Absolutely amazing','2024-02-08 17:35:55'),
(9,10,'Great effort','2024-02-09 13:05:15'),
(10,1,'Keep posting!','2024-02-10 18:50:05');

select * from comments;

INSERT INTO likes (Post_id, user_id, liked_at) 
VALUES(1,3,'2024-02-01 08:20:15'),
(2,4,'2024-02-02 09:35:40'),
(3,5,'2024-02-03 10:10:25'),
(4,6,'2024-02-04 13:45:55'),
(5,7,'2024-02-05 15:20:30'),
(6,8,'2024-02-06 07:40:10'),
(7,9,'2024-02-07 11:55:45'),
(8,10,'2024-02-08 17:25:35'),
(9,1,'2024-02-09 06:30:50'),
(10,2,'2024-02-10 19:15:05');

select * from likes;

/*Challenge 2 — JOIN Report
Display:
post_id, username, caption, total likes, total comments.*/
SELECT p.post_id,u.user_name,p.caption,COUNT(l.like_id) total_likes, COUNT(c.comment_id) total_comments
FROM posts p
JOIN users u ON u.user_id= p.user_id
LEFT JOIN comments c ON c.post_id=p.post_id
LEFT JOIN likes l ON l.post_id=p.post_id
GROUP BY p.post_id;

/*
Challenge 3 — Built-in Functions*/
-- Show usernames in UPPER case.
SELECT UPPER(user_name) username FROM users;
-- Extract month name from posted_at.
SELECT MONTHNAME(posted_at) Month_Posted FROM posts;
-- Return the length of each caption.*/
SELECT LENGTH(caption) Length_of_caption FROM posts;

/*Challenge 4 — UNION
Combine list of users who commented OR liked.*/

SELECT u.user_id,u.user_name,u.full_name FROM users u
JOIN comments c ON c.user_id=u.user_id
UNION
SELECT u.user_id,u.user_name,u.full_name FROM users u
JOIN likes l ON l.user_id=u.user_id
ORDER BY user_id;

SELECT * FROM likes;
SELECT * FROM comments;

/*---------------------------------------------------------------------------------------------------------------------------
USER DEFINED FUNCTION
 ---------------------------------------------------------------------------------------------------------------------------*/
 /*Challenge 1 — User Defined Function
Create a function:
GetUserEngagement(user_id)
Returns total likes + comments made by the user.*/

DELIMITER //
CREATE FUNCTION GetUserEngagement(eng_user_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE Total_likes INT;
    DECLARE Total_comments INT;
    SELECT COUNT(*) INTO Total_likes FROM likes WHERE user_id = p_user_id;
	 SELECT COUNT(*) INTO Total_comments FROM comments WHERE user_id = p_user_id;
     RETURN Total_likes + Total_comments;
END //

DELIMITER ;

SELECT * FROM likes;
SELECT * FROM comments;
SELECT GetUserEngagement(8);

/*Challenge 2 — Subquery
Find users who have more followers than the average follower count.*/
/*achu002,adhi003,ammu004,bala005,indhu015,sanju019,suji020 has more followers than average follower count*/

SELECT user_name FROM users WHERE user_id IN (SELECT following_id
FROM followers
GROUP BY following_id
HAVING COUNT(follower_id) > (SELECT AVG(Number_of_followers) Average_followers FROM (SELECT COUNT(follower_id) Number_of_followers FROM followers
GROUP BY following_id) AS Average_followers_count));



SELECT * FROM followers;


/*Challenge 3 — Stored Procedure
Stored procedure to retrieve all posts for a given username.*/
SELECT * FROM users;

DELIMITER $$
CREATE PROCEDURE posts(IN username VARCHAR(50))
BEGIN
	SELECT post_id,caption FROM posts 
	WHERE user_id =(SELECT user_id FROM users WHERE user_name = username);
END $$
DELIMITER ;

CALL posts('aarav01');
/*---------------------------------------------------------------------------------------------------------------------------
 VIEWS & TRIGGERS
  ---------------------------------------------------------------------------------------------------------------------------*/
  /*Challenge 1 — View
e a view post_summary showing:
post_id
username
caption
total likes
total comments */

CREATE VIEW post_summary AS
SELECT p.post_id,u.user_name,p.caption,COUNT(l.like_id) total_likes, COUNT(c.comment_id) total_comments
FROM posts p 
LEFT JOIN users u ON p.user_id = u.user_id
LEFT JOIN likes l ON l.post_id = p.post_id
LEFT JOIN comments c ON c.post_id = p.post_id
GROUP BY p.post_id;
SELECT * FROM posts;
SELECT * FROM likes;
SELECT * FROM comments;
SELECT * FROM post_summary;

/* Challenge 2 — Trigger
Trigger on likes table:
When a user likes a post, insert a row into a new table:
notifications (user_id, message, created_at) */
CREATE TABLE notifications(
user_id INT,
message TEXT,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY(user_id) REFERENCES users(user_id));

DELIMITER $$
CREATE TRIGGER like_notification
AFTER INSERT ON likes
FOR EACH ROW
BEGIN
    INSERT INTO notifications VALUES(
	(SELECT user_id FROM posts WHERE post_id = NEW.post_id),
    CONCAT((SELECT user_name FROM users WHERE user_id = NEW.user_id),' liked your post ',(SELECT caption FROM posts WHERE post_id = NEW.post_id)),
    NEW.liked_at);	
END $$

DELIMITER ;

INSERT INTO likes (post_id,user_id)VALUES(24,5);

SELECT * FROM likes;
SELECT * FROM notifications;

-- handling NULL values
SET SQL_SAFE_UPDATES = 0;
UPDATE posts SET caption = IFNULL(caption,'No caption');
/*---------------------------------------------------------------------------------------------------------------------------
FINAL PROJECT: SOCIAL MEDIA ANALYTICS
Complete end-to-end analysis:
Final Challenges 
---------------------------------------------------------------------------------------------------------------------------*/
-- Top influencers (users with highest total engagement)

select u.user_id, u.user_name Top_Influencers,count(distinct l.like_id)+count(distinct c.comment_id) as Total_engagement
from user_profiles u
left join post_records p on u.user_id=p.user_id
left join likes l on l.post_id=p.post_id
left join comments c on c.post_id=p.post_id
group by u.user_id
order by total_engagement desc;

-- Virality report (posts with unusually high engagement)

select p.post_id,count(distinct l.like_id)+count(distinct c.comment_id) as Engagement
from post_records p
left join likes l on l.post_id=p.post_id
left join comments c on c.post_id=p.post_id
group by p.post_id
having engagement > (
	select avg(total_engagement) 
	from (
        select count(*) as total_engagement 
        from likes 
        group by post_id
        ) t
);


-- User activity timeline (daily/weekly posting patterns)

select u.user_name, date(p.posted_at) as post_date, count(p.post_id) as Total_posts
from post_records p
left join user_profiles u on u.user_id=p.user_id
group by u.user_name, date(p.posted_at)
order by post_date;

-- Follower growth (who gained the most followers recently)

select following_id as user_id, count(*) as New_followers
from followers
where follow_date>=curdate() - interval 30 day
group by following_id
order by new_followers desc;

-- Trending hashtags (most used hashtags in last 30 days)

SELECT hashtag, COUNT(*) AS usage_count
FROM hashtags h
JOIN post_records p ON p.post_id = h.post_id
WHERE p.posted_at <= CURDATE() - INTERVAL 30 DAY
GROUP BY hashtag
ORDER BY usage_count DESC;


 