CREATE TABLE Enrolled (sid INTEGER NOT NULL,
cid INTEGER NOT NULL,
semesterid INTEGER NOT NULL,
PRIMARY KEY (sid, cid, semesterid));

CREATE TABLE CourseOffering (cid INTEGER NOT NULL,
semesterid INTEGER NOT NULL,
profid INTEGER,
roomid INTEGER,
PRIMARY key (cid, semesterid));

# (a) (5 points) Find all students who have taken the same course at least three times during their career,
# each time with a different professor. For each such student, list their sid exactly once.

SELECT DISTINCT(sid)
FROM Enrolled
NATURAL JOIN CourseOffering
GROUP BY sid, cid
HAVING COUNT(DISTINCT profid) > 2

# (b) (5 points) Some students may be lucky one semester because all the courses they take meet in the
# same room. Find all such students; list (studentid, semesterid) pairs with each pair appearing exactly once.

SELECT DISTINCT(sid, semesterid)
FROM Enrolled
NATURAL JOIN CourseOffering
GROUP BY sid, semesterid
HAVING COUNT(DISTINCT roomid) == 1

# (c) (6 points) Jaccard Similarity

SELECT e1.sid as e1id, e2.sid as e2id, COUNT(DISTINCT e1.cid)/inter.count
FROM Enrolled e1
JOIN Enrolled e2
ON (e1.sid<e2.sid and e1.cid=e2.cid)
JOIN (SELECT COUNT(DISTINCT cid) as count
FROM Enrolled
WHERE sid=e1.sid or sid=e2.sid) as inter
GROUP BY e1.sid, e2.sid

SELECT e1.sid, e2.sid, COUNT(DISTINCT e1.cid) as course_union
FROM Enrolled e1
JOIN Enrolled e2
ON (e1.sid < e2.sid and e2.cid = e1.cid)
GROUP BY e1.sid, e2.sid


