SELECT 7 as month, count(distinct user_id) as monthly_active_users FROM user_actions
where extract(month from event_date) = 7
  and extract(year from event_date) = 2022
  and user_id IN (
    select user_id
    from user_actions
    where extract(month from event_date) = 6
    and extract(year from event_date) = 2022
  );
