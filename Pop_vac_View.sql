--select continent, max(cast(total_deaths as decimal)) as deaths
--from CovidDeaths
--where continent is not null
--group by continent
--order by 2 desc

-- Create View to store data for later Visualization

create view PercentagePopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations as vaccinations,
sum(convert(int, vac.new_vaccinations)) over ( partition by dea.location order by dea.date)
	as RollingPeopleVaccinated   
from CovidDeaths dea join CovidVaccinations as vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null and population is not null
--order by 2,3


select *
from PercentagePopulationVaccinated