
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
