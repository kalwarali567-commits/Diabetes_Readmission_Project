--EDA

-- Readmission Distribution
SELECT
	readmitted,
	COUNT(*) AS patient_count
FROM diabetes_typed
GROUP BY readmitted
ORDER BY COUNT(*) DESC;



--Age VS Readmission
SELECT
	age,
	readmitted,
	COUNT(*) AS patient_count
FROM diabetes_typed
GROUP BY age,readmitted
ORDER BY COUNT(*) DESC;

--Gender Vs Readmission
SELECT
	gender,
	readmitted,
	COUNT(*) AS patient_count
FROM diabetes_typed
GROUP BY gender,readmitted
ORDER BY COUNT(*) DESC;



--Number Diagnoses vs Readmission
SELECT
	number_diagnoses,
	readmitted,
	COUNT(*) AS patient_count
FROM diabetes_typed
GROUP BY number_diagnoses,readmitted
ORDER BY number_diagnoses DESC;



--Previous Inpatient Visit VS Readmission
SELECT
	number_inpatient,
	readmitted,
	COUNT(*) AS patient_count
FROM diabetes_typed
GROUP BY number_inpatient,readmitted
ORDER BY patient_count DESC;



--Time in hospital VS Readmission
SELECT
	time_in_hospital,
	readmitted,
	COUNT(*) AS patient_count
FROM diabetes_typed
GROUP BY time_in_hospital,readmitted
ORDER BY patient_count DESC;



--Diabetes Medication Vs Readmission
SELECT
	diabetesMed,
	readmitted,
	COUNT(*) AS patient_count
FROM diabetes_typed
GROUP BY diabetesMed,readmitted
ORDER BY patient_count DESC;


--Insulin Vs Readmission
SELECT
	insulin,
	readmitted,
	COUNT(*) AS patient_count
FROM diabetes_typed
GROUP BY insulin,readmitted
ORDER BY patient_count DESC;


--Emergency Visit Vs Readmission
SELECT
	number_emergency,
	readmitted,
	COUNT(*) AS patient_count
FROM diabetes_typed
GROUP BY number_emergency,readmitted
ORDER BY patient_count DESC;



--Medication Change Vs Readmission
SELECT
	change,
	readmitted,
	COUNT(*) AS patient_count
FROM diabetes_typed
GROUP BY change,readmitted
ORDER BY patient_count DESC;


--A1C Result VS Readmission
SELECT
	A1Cresult,
	readmitted,
	COUNT(*) AS patient_count
FROM diabetes_typed
GROUP BY A1Cresult,readmitted
ORDER BY patient_count DESC;


--Glucose Result Vs Readmission
SELECT
	max_glu_serum,
	readmitted,
	COUNT(*) AS total_patient
FROM diabetes_typed
GROUP BY max_glu_serum,readmitted
ORDER BY total_patient DESC;

