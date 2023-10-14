

Select *
From 
	Covid_Project..Covid_Deaths
Where 
	continent is not null 
order by 
	3,4;


-- Select Data that we are going to be starting with

Select 
	Location, date, total_cases, new_cases, total_deaths, population
From 
	Covid_Project..Covid_Deaths
Where 
	continent is not null 
order by 
	1,2;



-- Chance of dying if you infected with covid in your country

Select 
	Location, date, total_cases,total_deaths, round((total_deaths/total_cases)*100,2) as Death_Percentage
From 
	Covid_Project..Covid_Deaths
Where 
	location like '%states%' and continent is not null 
order by	
	1,2;


-- Shows what percentage of population infected with Covid

Select 
	Location, date, Population, total_cases,  round((total_cases/population)*100,2) as Percent_Population_Infected
From 
	Covid_Project..Covid_Deaths
order by 
	1,2;


-- Countries with Highest Infection Rate compared to Population

Select 
	Location, Population, MAX(total_cases) as Highest_Infection_Count,  round(Max((total_cases/population))*100,2) as Percent_Population_Infected
From 
	Covid_Project..Covid_Deaths
Group by 
	Location, Population
order by 
	Percent_Population_Infected desc, location;


-- Countries with Highest Death Count per Population

Select 
	Location, MAX(cast(Total_deaths as int)) as Total_Death_Count
From 
	Covid_Project..Covid_Deaths
Where 
	continent is not null 
Group by 
	Location
order by 
	Total_Death_Count desc, Location;



-- Showing contintents with the highest death count per population

Select 
	continent, MAX(cast(Total_deaths as int)) as Total_Death_Count
From 
	Covid_Project..Covid_Deaths
Where 
	continent is not null 
Group by 
	continent
order by 
	Total_Death_Count desc;



-- GLOBAL NUMBERS

Select 
	-- date, 
	SUM(new_cases) as total_cases, SUM( cast(new_deaths as int )) as total_deaths, round(SUM(convert(int, new_deaths ))/SUM(New_Cases)*100,2) as Death_Percentage
From 
	Covid_Project..Covid_Deaths
where 
	continent is not null 
 -- Group By date
order by 
	1,2;



-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select 
	dt.continent, dt.location, dt.date, dt.population, vac.new_vaccinations
	,SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dt.Location Order by dt.location, dt.Date) as Rolling_Sum_People_Vaccinated
From 
	Covid_Project..Covid_Deaths dt
Join 
	Covid_Project..Covid_Vaccinations vac
	On dt.location = vac.location and dt.date = vac.date
where 
	dt.continent is not null 
order by 
	2,3;


-- Window Funtion (Partition)

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, Rolling_Sum_People_Vaccinated)
as
(
Select 
	dt.continent, dt.location, dt.date, dt.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dt.Location Order by dt.location, dt.Date) as Rolling_Sum_People_Vaccinated
From 
	Covid_Project..Covid_Deaths dt
Join 
	Covid_Project..Covid_Deaths vac
	On dt.location = vac.location and dt.date = vac.date
where 
	dt.continent is not null 
)
Select *, round((Rolling_Sum_People_Vaccinated/Population)*100,2) as Vaccinated_Percentage
From PopvsVac;




DROP Table if exists #Percent_Population_Vaccinated
Create Table #Percent_Population_Vaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
Rolling_Sum_People_Vaccinated numeric
)

Insert into #Percent_Population_Vaccinated
Select 
	dt.continent, dt.location, dt.date, dt.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dt.Location Order by dt.location, dt.Date) as Rolling_Sum_People_Vaccinated
From 
	Covid_Project..Covid_Deaths dt
Join 
	Covid_Project..Covid_Deaths vac
	On dt.location = vac.location and dt.date = vac.date
where 
	dt.continent is not null ;

Select *, round((Rolling_Sum_People_Vaccinated/Population)*100,2)
From #Percent_Population_Vaccinated
