DO
$do$
DECLARE
  end_dates  record;
BEGIN
  FOR end_dates in select distinct end_date from assignments where end_date > date '2022-03-01' order by end_date
  LOOP
    IF
    (select count(distinct user_id) 
      from assignments join users on users.id=assignments.user_id 
      where 
        enabled and
        (date '2022-03-01', date '2022-03-31') overlaps (start_date, end_date) and
        end_date > end_dates.end_date) / 
    (select count(id) from users where enabled)::decimal <= 0.5
    then
    RAISE NOTICE '%', end_dates.end_date + interval '1 day';
    EXIT;
    END IF;
  END LOOP;
END
$do$;
