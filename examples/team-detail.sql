-- Compute the number of off-hours incidents that occur off-hours
-- (Beijing time) per service over the last 28 days.

with timezoned_incidents as (
select
  incidents.id,
  incidents.service_id,
  incidents.created_at at time zone 'Asia/Shanghai' as local_created_at
from
  incidents
where
  incidents.created_at > now()-'28 days'::interval
)

select
  services.name as service,
  count(timezoned_incidents.id) as incidents
from
  timezoned_incidents,
  services
where
-- Add filter for different Team/Service services.name in ( 'aiops' ) and 
  timezoned_incidents.service_id = services.id and
  -- On-hours = Monday through Friday, 9:00a thorugh 6:00p.
  not (extract(dow from local_created_at) >= 1 and
       extract(dow from local_created_at) <= 5 and
       extract(hour from local_created_at) >= 9 and
       extract(hour from local_created_at) <= 17)
group by
  service
order by
  incidents desc
;
