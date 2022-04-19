DO
$do$
DECLARE
  march_days  record;
  total_hours int := 0;
  date_iterator date;
BEGIN
  FOR march_days in (select
  case
    when start_date <= DATE '2022-03-01' then DATE '2022-03-01'
    when start_date > DATE '2022-03-01' then start_date
  end as sd,
  case
    when end_date < DATE '2022-03-31' then end_date
    when end_date >= DATE '2022-03-31' then DATE '2022-03-31'
  end as ed
  from assignments where 
    (DATE '2022-03-01', DATE '2022-03-31') overlaps (start_date, end_date))
  LOOP
    date_iterator := march_days.sd;
    LOOP
      IF (date_part('dow', date_iterator) IN (1, 2, 3, 4, 5)) THEN
        total_hours := total_hours + 8; 
      END IF;
      date_iterator := date_iterator + interval '1 day';
      IF (date_iterator > march_days.ed) THEN
        EXIT;
      END IF;
    END LOOP;
  END LOOP;
  RAISE NOTICE '%',total_hours;
END
$do$;
