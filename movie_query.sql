/*  Q1: Find the titles of all movies directed by Steven Spielberg. */
SELECT title FROM Movie
WHERE director = 'Steven Spielberg'

/*  Q2: Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order.  */
SELECT DISTINCT movie.year as MovieYear from Movie
INNER JOIN Rating on rating.mID = movie.mID
WHERE Stars = '4' OR Stars = '5'
ORDER BY MovieYear

--  Q3: Find the titles of all movies that have no ratings. 
SELECT DISTINCT movie.title as Title from Movie
LEFT JOIN Rating on rating.mID = movie.mID
WHERE stars is NULL

-- Q4:  Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date. 
SELECT DISTINCT reviewer.name as reviewer from Reviewer
LEFT JOIN Rating on rating.rID = reviewer.rID
WHERE ratingDate IS NULL

/*  Q5: Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. 
Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars.  */
SELECT DISTINCT reviewer.name, movie.title, rating.stars, rating.ratingDate
FROM Rating
LEFT JOIN Movie ON rating.mID = movie.mID 
LEFT JOIN Reviewer ON rating.rID = reviewer.rID
ORDER BY reviewer.name, movie.title, rating.stars


/*  Q6: For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie.  */
SELECT name, Movie.title FROM Reviewer 
INNER JOIN Rating Rat1 ON Reviewer.rID = Rat1.rID
INNER JOIN Rating Rat2 ON Reviewer.rID = Rat2.rID and Rat2.mID = Rat1.mID
INNER JOIN Movie ON Movie.mID = Rat1.mID
WHERE Rat2.ratingDate > Rat1.ratingDate AND Rat2.stars > Rat1.stars

/*  Q7: For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title.  */
SELECT Movie.title, max(Rating.stars) as max_stars
FROM Movie, Rating
WHERE Rating.mID = Movie.mID
GROUP BY Movie.title


/*  Q8: For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title.  */
SELECT Movie.title, (max(stars) - min(stars)) as rating_spread
FROM Movie
JOIN Rating ON Rating.mID = Movie.mID
GROUP BY Movie.title
ORDER BY rating_spread DESC

/*  Q9: Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.)  */

SELECT AVG(Before1980.avg) - AVG(After1980.avg) 
FROM (SELECT Movie.title, avg(stars) AS AVG
FROM Movie, Rating
WHERE Movie.mID = Rating.mID AND year < 1980
GROUP BY Movie.title) Before1980,
(SELECT Movie.title, avg(stars) AS AVG
FROM Movie, Rating
WHERE Movie.mID = Rating.mID AND year >= 1980
GROUP BY Movie.title) After1980