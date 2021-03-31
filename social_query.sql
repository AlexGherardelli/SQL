--  Q1 Find the names of all students who are friends with someone named Gabriel. SELECT DISTINCT name FROM Highschooler h
SELECT DISTINCT name FROM Highschooler h
JOIN Friend f ON h.ID = f.ID1
WHERE ID2 IN (SELECT ID FROM Highschooler
WHERE name = 'Gabriel') 

-- Q2: For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name and grade of the student they like. 

SELECT DISTINCT h1.name, h1.grade, h2.name, h2.grade
FROM Likes
JOIN Highschooler h1 On h1.ID = Likes.ID1 
JOIN Highschooler h2 ON h2.ID = Likes.ID2
WHERE (h1.grade - h2.grade) >= 2

-- Q3:  For every pair of students who both like each other, return the name and grade of both students. Include each pair only once, with the two names in alphabetical order. 
SELECT DISTINCT h1.name, h1.grade, h2.name, h2.grade
FROM Highschooler h1, Highschooler h2, Likes l1, Likes l2
WHERE (H1.ID = L1.ID1 AND H2.ID = L1.ID2) AND (H2.ID = L2.ID1 AND H1.ID = L2.ID2) and h1.name < h2.name
ORDER by h1.name

-- Q4:  Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades. Sort by grade, then by name within each grade. 
SELECT DISTINCT h.name, h.grade FROM Highschooler h
WHERE NOT EXISTS (SELECT * FROM Likes WHERE h.ID = Likes.ID1 OR h.ID = Likes.ID2)
ORDER BY h.grade, h.name

--  Q5: For every situation where student A likes student B, but we have no information about whom B likes (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades. 
SELECT h1.name, h1.grade, h2.name, h2.grade
FROM Highschooler as h1, Highschooler as h2, Likes
WHERE (h1.ID = Likes.ID1 AND h2.ID = Likes.ID2) AND h2.ID NOT IN (SELECT ID1 FROM Likes)

-- Q6:  Find names and grades of students who only have friends in the same grade. Return the result sorted by grade, then by name within each grade. 

SELECT name, grade
FROM Highschooler
WHERE ID NOT IN (SELECT ID1 FROM Friend f, Highschooler h1, Highschooler h2
WHERE h1.ID = f.ID1 AND h2.ID = f.ID2 AND h1.grade <> h2.grade)
ORDER BY grade, name

-- Q7:  For each student A who likes a student B where the two are not friends, find if they have a friend C in common (who can introduce them!). For all such trios, return the name and grade of A, B, and C. 

SELECT  A.name, A.grade, B.name, B.grade, C.name, C.grade
FROM Highschooler A, Highschooler B, Highschooler C, Likes l, Friend f1, Friend f2
WHERE (A.ID = l.ID1 AND B.ID = l.ID2) and B.ID NOT IN (SELECT ID2 FROM Friend WHERE ID1 = A.ID)
AND (A.ID = f1.ID1 AND C.ID = f1.ID2) AND (B.ID = f2.ID1 AND C.ID = f2.ID2)