-- Winners from 1950: Change the query shown so that it displays Nobel prizes for 1950. 
SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950

--  1962 Literature: Show who won the 1962 prize for Literature. 
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature'

--    Show the year and subject that won 'Albert Einstein' his prize. 
SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein'

-- Give the name of the 'Peace' winners since the year 2000, including 2000. 
SELECT winner
FROM nobel
WHERE subject = 'Peace' AND yr >= 2000

-- Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive. 
SELECT *
FROM nobel
WHERE subject = 'Literature'
AND yr BETWEEN 1980 AND 1989

-- Show all details of the presidential winners: Theodore Roosevelt, Woodrow Wilson, Jimmy Carter, Barack Obama
SELECT * FROM nobel
WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama')

-- Show the winners with first name John 
SELECT winner FROM nobel WHERE winner Like 'John %'

-- Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984.
SELECT * FROM nobel WHERE subject = 'Physics' AND yr = 1980 OR subject = 'Chemistry' AND yr = 1984

-- Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine
SELECT yr, subject, winner FROM nobel
WHERE NOT subject IN ('Chemistry', 'Medicine') AND yr = 1980

-- Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004) 
SELECT yr, subject, winner FROM nobel
WHERE (subject = 'Medicine' AND yr < 1910) XOR(subject='Literature' AND yr >= 2004)

-- Umlaut: Find all details of the prize won by PETER GRÜNBERG 
SELECT * FROM nobel
WHERE winner = 'Peter Grünberg'

-- Apostrophe: Find all details of the prize won by EUGENE O'NEILL 
SELECT * FROM nobel WHERE winner = 'Eugene O''Neill'

-- Knights of the realm: List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.
SELECT winner, yr, subject FROM nobel 
WHERE winner LIKE 'Sir%'
ORDER BY yr DESC, winner

-- Chemistry and Physics last: Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last.
SELECT winner, subject
  FROM nobel
 WHERE yr=1984
 ORDER BY subject IN ('Physics', 'Chemistry') = 1, subject, winner

--  Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name FROM world 
WHERE continent = 'Europe' and gdp/population > (SELECT gdp/population FROM world WHERE name = 'United Kingdom')

-- List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
SELECT name, continent FROM world
WHERE continent IN (SELECT continent FROM world WHERE name IN ('Australia', 'Argentina'))
ORDER BY name

-- Which country has a population that is more than Canada but less than Poland? Show the name and the population.
SELECT name, population FROM world
WHERE population > (SELECT population FROM world WHERE name = 'Canada') AND population < (SELECT population FROM world WHERE name = 'Poland')

-- Percentages of Germany: Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany. Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
SELECT name, concat(round((100 * population / (SELECT population FROM world WHERE name = 'Germany')), 0), '%')
FROM world
WHERE continent = 'Europe' 

-- Find the largest country (by area) in each continent, show the continent, the name and the area: 
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0)
-- First country of each continent (alphabetically)
SELECT continent,name 
FROM world x
WHERE x.name <= ALL(SELECT y.name FROM world y
                    WHERE x.continent=y.continent)
ORDER BY continent
