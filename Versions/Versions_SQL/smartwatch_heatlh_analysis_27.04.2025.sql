SELECT *
FROM smartwatch_health_analysis;
--dodanie nowych kolumn
ALTER TABLE smartwatch_health_analysis 
ADD COLUMN sleep_duration_hours integer,
ADD COLUMN sleep_duration_minutes integer,
ADD COLUMN sleep_duration_seconds integer,
ADD COLUMN sleep_duration_fixed time;
-- zaokrąglanie wartości i uzupełnianie nowych kolumn
UPDATE smartwatch_health_analysis
SET 
bpm = ROUND(bpm::numeric, 2), 
blood_oxygen_lvl = ROUND(blood_oxygen_lvl::numeric, 2),
step_count = ROUND(step_count::numeric, 0),
sleep_duration_hours = FLOOR(sleep_duration)::int, 
sleep_duration_minutes = ROUND((sleep_duration - FLOOR(sleep_duration)) * 60)::int,
sleep_duration_seconds = FLOOR(RANDOM() * 59)::int; -- sekundy dobrane losowo
--dopasowanie formatu danych
UPDATE smartwatch_health_analysis
SET sleep_duration_minutes = 59
WHERE sleep_duration_minutes = 60;

SELECT COUNT(*)
FROM smartwatch_health_analysis
WHERE sleep_duration_minutes = 60;

SELECT COUNT(*)
FROM smartwatch_health_analysis
WHERE sleep_duration_seconds = 60;
--konkatenacja
UPDATE smartwatch_health_analysis
SET 
sleep_duration_fixed = (LPAD(sleep_duration_hours::text, 2, '0') || ':' || LPAD(sleep_duration_minutes::text, 2, '0') || ':' || LPAD(sleep_duration_seconds::text, 2, '0'))::time;

SELECT sleep_duration_hours
FROM smartwatch_health_analysis;
--redukcja roboczych kolumn
ALTER TABLE smartwatch_health_analysis
DROP COLUMN sleep_duration,
DROP COLUMN sleep_duration_hours,
DROP COLUMN sleep_duration_minutes,
DROP COLUMN sleep_duration_seconds;
--rename
ALTER TABLE smartwatch_health_analysis
RENAME COLUMN sleep_duration_fixed TO sleep_duration;

SELECT COUNT(*)
FROM smartwatch_health_analysis;
