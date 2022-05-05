/*Select location ,MAX(total_cases) from PortfolioProject..CovidDeath
where location = 'Pakistan'
group by location */
-- total percentage of death

select location,date,total_cases, total_deaths ,concat( ((total_deaths/total_cases)*100) ,'%') as Death_percentage from PortfolioProject..CovidDeath
where location like '%tan%' ;  


--total cases vs population
select location,date,total_cases, population ,concat( ((total_cases/population)*100) ,'%') as Death_percentage from PortfolioProject..CovidDeath
where location like '%states%' order by 1,2;  

--Death till record
select location ,MAX(total_deaths) DeathPerCountry from PortfolioProject..CovidDeath group by location order by 1

--looking for country with higest infecton wrt to population
Select location ,MAX(total_cases) as TotalInfection,population,MAX((total_cases/population))*100 as MostInfection
from  PortfolioProject..CovidDeath group by location,population  order by MostInfection desc

--Highest death count per population
Select location,MAX(cast(total_deaths as int)) 
from PortfolioProject..CovidDeath where continent is not null group by location order by 2 desc 

--showing highest death count continent wise

Select continent,MAX(cast(total_deaths as int)) 
from PortfolioProject..CovidDeath where continent is not null group by continent order by 2 desc 

--Global insight
Select location,date ,total_cases,total_deaths,population,(total_cases/population)*100 as MostInfection
from  PortfolioProject..CovidDeath   order by 1 asc

select date,sum(new_cases) as total_cases ,sum(cast(new_deaths as int)) as total_death, (sum(cast( new_deaths as int))/sum(new_cases))*100 as DeathPercent
from PortfolioProject..CovidDeath  where continent  is not null group by date order by 1

--Showing continext with highest death count per population
select continent,MAX(cast(total_deaths as int)) from PortfolioProject..CovidDeath where continent is not null group by continent 

--vaccination data
select * from PortfolioProject..CovidVaccination

--joining both tables using locatio and date
Select * from PortfolioProject..CovidDeath
join PortfolioProject..CovidVaccination
on CovidDeath.location = CovidDeath.location
and CovidDeath.date  = CovidVaccination.date


--looking for total population vs vaccination 
Select dea.continent , dea.location , dea.date , dea.population ,vac.new_vaccinations 
,SUM(CONVERT(int,vac.new_vaccinations )) OVER(PARTITION BY dea.location order by dea.location,dea.date ) AS total_vacinated
from PortfolioProject..CovidDeath dea
join PortfolioProject..CovidVaccination vac
on dea.location = vac.location
and dea.date  = vac.date
where dea.continent is not null
order by 1,2,3