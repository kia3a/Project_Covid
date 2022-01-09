-- original, all columns 
 SELECT *
FROM covid_deaths
WHERE CONTINENT is not null
ORDER BY location;

SELECT location, CONTINENT,date, total_cases, new_cases, total_deaths, population
FROM covid_deaths
WHERE CONTINENT is not null
ORDER BY location,continent;

-- Looking at Total Cases vs Total Deaths in Percentage 
-- Shows the likelihood of dying if you get covid by country

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percent
FROM covid_deaths
WHERE location like "%states%"
ORDER BY location,date;

-- Looking at Total Cases vs Population

SELECT location, date, total_cases, population, (total_cases/population)*100 as cases_percent
FROM covid_deaths
WHERE location like "%states%"
ORDER BY location,date;

-- Looking for countries with the highest infection rate compared to population

SELECT location, MAX(total_cases) as 'total_infection', population, MAX((total_cases/population)*100) as infection_percent
FROM covid_deaths
WHERE continent is not null
GROUP BY location, POPULATION
ORDER BY max_cases_percent DESC;


-- Looking for countries with the highest death count per population

SELECT location, MAX(CAST(total_deaths as decimal)) as 'max_death'
FROM covid_deaths
WHERE CONTINENT <> ''
GROUP BY location
ORDER BY max_death DESC;

-- deaths per continent

SELECT continent, MAX(CAST(total_deaths as decimal)) as 'max_death'
FROM covid_deaths
WHERE CONTINENT <> ''
GROUP BY continent
ORDER BY max_death DESC;

-- Showing the continents with highest cases

SELECT continent, MAX(CAST(total_cases as decimal)) as 'cases'
FROM covid_deaths
WHERE CONTINENT <> ''
GROUP BY continent
ORDER BY cases DESC;

-- Showing the continents with highest percent of cases per population

SELECT continent, SUM(total_cases)/sum(population)*100 AS percent_case
FROM covid_deaths
WHERE CONTINENT <> ''
GROUP BY continent
ORDER BY percent_case DESC;

-- Showing the continents with highest mortality

SELECT continent, SUM(new_deaths)/SUM(new_cases)*100  AS percent_case
FROM covid_deaths
WHERE CONTINENT <> ''
GROUP BY continent
ORDER BY percent_case DESC;




