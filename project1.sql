-- Return the name of the columns
-- This show all the columns names and type of the covid_deaths table
-- I used this to understand the information that I am working with and select what columns I need for a correct analysis. 
SHOW COLUMNS FROM covid_deaths;

-- In the cleaning process I notice that some line don't have an specific country, I discard this lines for the country analysis
SELECT location, CONTINENT,date, total_cases, new_cases, total_deaths, population
FROM covid_deaths
WHERE CONTINENT <> ''
ORDER BY location,continent;

-- Looking at Total Cases vs Total Deaths in Percentage 
-- Shows the likelihood of dying if you get covid by country per day
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percent
FROM covid_deaths
WHERE location like "%states%"
ORDER BY location,date;

-- Looking at Total Cases vs Population
-- This show the percentage of population that got COVID
SELECT location, date, total_cases, population, (total_cases/population)*100 as cases_percent
FROM covid_deaths
WHERE location like "%states%"
ORDER BY location,date;

-- Looking for countries with the highest infection rate compared to population and date
SELECT location, MAX(total_cases) as 'total_infection', population, MAX((total_cases/population)*100) as infection_percent, date
FROM covid_deaths
WHERE continent <>''
GROUP BY location, POPULATION, date
ORDER BY infection_percent DESC;


-- Looking for countries with the highest death count per population
SELECT location, MAX(CAST(total_deaths as decimal)) as 'max_death'
FROM covid_deaths
WHERE CONTINENT <> ''
GROUP BY location
ORDER BY max_death DESC;

-- Number of deaths per continent
SELECT continent, MAX(CAST(total_deaths as decimal)) as 'max_death'
FROM covid_deaths
WHERE CONTINENT <> ''
GROUP BY continent
ORDER BY max_death DESC;

-- Showing the continents with highest number of COVID cases
SELECT continent, MAX(CAST(total_cases as decimal)) as 'cases'
FROM covid_deaths
WHERE CONTINENT <> ''
GROUP BY continent
ORDER BY cases DESC;

-- Showing the continents with highest percent of cases per population
SELECT continent, SUM(total_cases)/sum(population)*100 AS percent_case
FROM portafolio_covid.covid_deaths
WHERE CONTINENT <> ''
GROUP BY continent
ORDER BY percent_case DESC;

-- Showing the continents with highest probabily of mortality
SELECT continent, SUM(new_deaths)/SUM(new_cases)*100  AS percent_case
FROM covid_deaths
WHERE CONTINENT <> ''
GROUP BY continent
ORDER BY percent_case DESC;

-- Compare the number of persons that were hospitalized against number of cases
SELECT location, sum(hosp_patients) as total_hosp_patients, sum(new_cases) AS total_cases, SUM(ICU_PATIENTS) as total_ICU_PATIENTS, (sum(CAST(hosp_patients as decimal))/sum(new_cases))*100 AS percent_hosp
FROM covid_deaths
where hosp_patients <> 0
GROUP BY location
ORDER BY percent_hosp DESC;


-- Compare the number of persons that were hospitalized against number of patients that end in UCI
SELECT location, sum(hosp_patients) as total_hosp_patients, SUM(ICU_PATIENTS) as total_ICU_PATIENTS, (sum(CAST(ICU_patients as decimal))/sum(HOSP_patients))*100 AS percent_icu
FROM covid_deaths
where hosp_patients <> 0
 AND icu_patients <> 0
GROUP BY location
ORDER BY percent_icu DESC

