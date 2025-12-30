-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

WITH T1 AS(
SELECT sent_at::Date As sent_at_day, user_name, COUNT(message_id) AS count_message
FROM npn_users u JOIN npn_messages m ON m.sender_id=u.user_id
GROUP BY sent_at::Date, user_name ),
t2 AS (SELECT sent_at_day, user_name, 
  DENSE_RANK() OVER(PARTITION BY sent_at_day
  ORDER BY count_message DESC) AS Rang
  FROM t1)
SELECT sent_at_day, user_name FROM t2 WHERE Rang=1;
