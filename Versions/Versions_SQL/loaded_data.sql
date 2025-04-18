CREATE TABLE smartwatch_health_analysis(
user_id INT,
bpm FLOAT,
blood_oxygen_lvl FLOAT,
step_count FLOAT,
sleep_duration FLOAT,
activity_lvl VARCHAR(30),
stress_lvl INT,
PRIMARY KEY (user_id)
);

COPY smartwatch_health_analysis(user_id, bpm, blood_oxygen_lvl, step_count, sleep_duration, activity_lvl, stress_lvl)
FROM 'C:\Users\mrolo\Desktop\cleaned_data.csv'
DELIMITER ','
CSV HEADER;

SELECT *
FROM smartwatch_health_analysis
;


DROP TABLE smartwatch_health_analysis;