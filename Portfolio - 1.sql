--select *
--from PortfolioProject ..CovidData
--order by 3,4

--select *
--from PortfolioProject .. CovidVacinations
--order by 3,4


--Now Select data that we are going to be using

select Location, date, total_cases, new_cases, total_deaths, population 
from PortfolioProject..CovidData
order by 1,2


--Looking at total_cases and total_deaths
--uzbekistan dagi olim darajasini chiqarib beradi
--select Location, date, total_cases, total_deaths, (CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0))*100 as DeathPercentage
--from PortfolioProject..CovidData
--where location like '%bekistan%'
--order by 1,2



--Looking at total_cases and population
--uzbekistan dagi kasallanish foizini chiqarib beradi
--select Location, date, total_cases, population, (CONVERT(float, total_cases) / NULLIF(CONVERT(float, population), 0))*100 as PercentofPopulation
--from PortfolioProject..CovidData
--where location like '%bekistan%'
--order by 1,2


--looking at countries wiht highest infection rate compared to population

--select Location,population, MAX(total_cases) as HighestInfectionCount, MAX(CONVERT(float, total_cases) / NULLIF(CONVERT(float, population), 0))*100 as PercentPopulationInfected
--from PortfolioProject..CovidData
--group by population, location
--order by PercentPopulationInfected desc

--showing countries with highest death count per population

select Location, MAX(CAST( total_deaths as int)) as TotalDeathsCount
from PortfolioProject..CovidData
where continent is not NULL
group by population, location
order by TotalDeathsCount desc

--cast is convert into other type


--let's break table into groups by continent

select continent, MAX(CAST( total_deaths as int)) as TotalDeathsCount
from PortfolioProject..CovidData
where continent is not NULL
group by continent
order by TotalDeathsCount desc

--cast is convert into other type

select new_cases, new_deaths
from PortfolioProject .. CovidData

select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
from PortfolioProject .. CovidData
where continent is not null
order by 1,2


--2 tables we will join together and looking at total populations and vaccinations

select data.continent, data.location, data.date, data.population, vaca.new_vaccinations
from PortfolioProject .. CovidData data
join PortfolioProject .. CovidVacinations vaca
	on data.location = vaca.location
	and data.date = vaca.date
where data.continent is not null
order by 2,3
