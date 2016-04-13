SELECT
  *
FROM
  departments
JOIN
  employees ON department.id = employee.dept_id
WHERE
  department.name = ?;

SELECT
  COUNT(*)
FROM
  users;


User.count

SELECT
  COUNT(*)
FROM
  users
WHERE
  user.active = true;

User.where(active: true).count

SELECT
  COUNT(*)
FROM
  users
WHERE
  users.last_login BETWEEN :time_period_start AND :time_period_end ;

User.where(last_login: (:time_period_start..:time_period_end)).count
