
-- ==========================================
-- STAGING TABLE CREATION
-- ==========================================
CREATE TABLE stg_diabetes_raw (
	encounter_id TEXT,
	patient_nbr TEXT,
	race TEXT,
	gender TEXT,
	age TEXT,
	weight TEXT,
	admission_type_id TEXT,
	discharge_disposition_id TEXT,
	admission_source_id TEXT,
	time_in_hospital TEXT,
	payer_code TEXT,
	medical_specialty TEXT,
	num_lab_procedures TEXT,
	num_procedures TEXT,
	num_medications TEXT,
	number_outpatient TEXT,
	number_emergency TEXT,
	number_inpatient TEXT,
	diag_1 TEXT,
	diag_2 TEXT,
	diag_3 TEXT,
	number_diagnoses TEXT,
	max_glu_serum TEXT,
	A1Cresult TEXT,
	metformin TEXT,
	repaglinide TEXT,
	nateglinide TEXT,
	chlorpropamide TEXT,
	glimepiride TEXT,
	acetohexamide TEXT,
	glipizide TEXT,
	glyburide TEXT,
	tolbutamide TEXT,
	pioglitazone TEXT,
	rosiglitazone TEXT,
	acarbose TEXT,
	miglitol TEXT,
	troglitazone TEXT,
	tolazamide TEXT,
	examide TEXT,
	citoglipton TEXT,
	insulin TEXT,
	glyburide_metformin TEXT,
	glipizide_metformin TEXT,
	glimepiride_pioglitazone TEXT,
	metformin_rosiglitazone TEXT,
	metformin_pioglitazone TEXT,
	change TEXT,
	diabetesMed TEXT,
	readmitted TEXT
);





-- ==========================================
-- INITIAL DATA INSPECTION
-- ==========================================

SELECT * FROM stg_diabetes_raw;


SELECT COUNT(*)
FROM stg_diabetes_raw;

-- Check for duplicate encounter IDs
	
SELECT encounter_id, COUNT(*) AS total
FROM stg_diabetes_raw
GROUP BY encounter_id
ORDER BY total DESC;


-- Validate categorical values

SELECT COUNT(DISTINCT gender)
FROM stg_diabetes_raw;
SELECT DISTINCT race FROM stg_diabetes_raw;

SELECT medical_specialty, COUNT(*) AS freq
FROM stg_diabetes_raw
GROUP BY medical_specialty
ORDER BY freq DESC;





SELECT COUNT(*)
FROM stg_diabetes_raw;

SELECT *
FROM stg_diabetes_raw
LIMIT 10;

-- ==========================================
-- DATA TYPE VALIDATION
-- ==========================================

---Check data types
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'stg_diabetes_raw';


SELECT age,
	COUNT(*)
FROM stg_diabetes_raw
GROUP BY age;







CREATE TABLE diabetes_typed AS
SELECT
CAST(race AS VARCHAR(50)) AS race,
CAST(gender AS VARCHAR(20)) AS gender,
CAST(age AS VARCHAR(20)) AS age,
CAST(admission_type_id AS INTEGER) AS admission_type_id,
CAST(discharge_disposition_id AS INTEGER) AS discharge_disposition_id,
CAST(admission_source_id AS INTEGER) AS admission_source_id,
CAST(time_in_hospital AS INTEGER) AS time_in_hospital,
CAST(payer_code AS VARCHAR(50)) AS payer_code,
CAST(medical_specialty AS VARCHAR(100)) AS medical_specialty,
CAST(num_lab_procedures AS INTEGER) AS num_lab_procedures,
CAST(num_procedures AS INTEGER) AS num_procedures,
CAST(num_medications AS INTEGER) AS num_medications,
CAST(number_outpatient AS INTEGER) AS number_outpatient,
CAST(number_emergency AS INTEGER) AS number_emergency,
CAST(number_inpatient AS INTEGER) AS number_inpatient,
CAST(diag_1 AS VARCHAR(20)) AS diag_1,
CAST(diag_2 AS VARCHAR(20)) AS diag_2,
CAST(diag_3 AS VARCHAR(20)) AS diag_3,
CAST(number_diagnoses AS INTEGER) AS number_diagnoses,
CAST(max_glu_serum AS VARCHAR(20)) AS max_glu_serum,
CAST(A1Cresult AS VARCHAR(20)) AS A1Cresult,
CAST(metformin AS VARCHAR(20)) AS metformin,
CAST(repaglinide AS VARCHAR(20)) AS repaglinide,
CAST(nateglinide AS VARCHAR(20)) AS nateglinide,
CAST(glimepiride AS VARCHAR(20)) AS glimepiride,
CAST(glipizide AS VARCHAR(20)) AS glipizide,
CAST(glyburide AS VARCHAR(20)) AS glyburide,
CAST(pioglitazone AS VARCHAR(20)) AS pioglitazone,
CAST(rosiglitazone AS VARCHAR(20)) AS rosiglitazone,
CAST(acarbose AS VARCHAR(20)) AS acarbose,
CAST(miglitol AS VARCHAR(20)) AS miglitol,
CAST(tolazamide AS VARCHAR(20)) AS tolazamide,
CAST(insulin AS VARCHAR(20)) AS insulin,
CAST(glyburide_metformin AS VARCHAR(20)) AS glyburide_metformin,
CAST(glipizide_metformin AS VARCHAR(20)) AS glipizide_metformin,
CAST(change AS VARCHAR(10)) AS change,
CAST(diabetesMed AS VARCHAR(10)) AS diabetesMed,
CAST(readmitted AS VARCHAR(10)) AS readmitted
FROM stg_diabetes_raw;

-- ==========================================
-- DATA TYPE VALIDATION
-- ==========================================


SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'diabetes_typed';

-- ==========================================
-- DATA QUALITY CHECKS
-- ==========================================

SELECT
	COUNT(*) AS total_rows,
	SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS missing_age,
	SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS missing_gender
FROM diabetes_typed;


SELECT DISTINCT gender
FROM diabetes_typed;

SELECT
	DISTINCT gender,
	COUNT(*) AS total_count
FROM stg_diabetes_raw
GROUP BY gender;


SELECT race, COUNT(*)
FROM diabetes_typed
GROUP BY race;

SELECT payer_code, COUNT(*)
FROM diabetes_typed
GROUP BY payer_code
ORDER BY COUNT(*) DESC;


SELECT medical_specialty, COUNT(*)
FROM diabetes_typed
GROUP BY medical_specialty
ORDER BY COUNT(*) DESC;

-- Check numerical ranges for outliers


SELECT MIN(time_in_hospital),
	MAX(time_in_hospital)
FROM diabetes_typed;

SELECT 	
	MIN(num_lab_procedures),
	MAX(num_lab_procedures)
FROM diabetes_typed;


SELECT 	
	MIN(num_procedures),
	MAX(num_procedures)
FROM diabetes_typed;

SELECT 	
	MIN(num_medications),
	MAX(num_medications)
FROM diabetes_typed;

SELECT
	MIN(number_outpatient),
	MAX(number_outpatient)
FROM diabetes_typed;

SELECT
	MIN(number_emergency),
	MAX(number_emergency)
FROM diabetes_typed;

SELECT
	MIN(number_inpatient),
	MAX(number_inpatient)
FROM diabetes_typed;

SELECT
	MIN(number_diagnoses),
	MAX(number_diagnoses)
FROM diabetes_typed;


SELECT	readmitted, COUNT(*)
FROM diabetes_typed
GROUP BY readmitted
ORDER BY COUNT(*) DESC;

SELECT	diabetesMed, COUNT(*)
FROM diabetes_typed
GROUP BY diabetesMed
ORDER BY COUNT(*) DESC;






-- ==========================================
-- DASHBOARD ANALYTICAL VIEWS
-- ==========================================


--Readmission Summary
-- Executive dashboard KPI source
CREATE VIEW vw_readmission_summary AS 
SELECT
	readmitted,
	COUNT(*) AS patient_count,
	ROUND(
	COUNT(*) * 100/SUM(COUNT(*)) OVER(),
	2
	) AS percentage
FROM diabetes_typed
GROUP BY readmitted;

--Age VS Readmission
CREATE VIEW vw_age_readmission AS 
SELECT
	age,
	readmitted,
	COUNT(*) AS patient_count
FROM diabetes_typed
GROUP BY age,readmitted;


--Previous Inpatient Visit VS Readmission
-- Readmission driver analysis
CREATE VIEW vw_inpatient_readmission AS 
SELECT
	number_inpatient,
	COUNT(*) AS total_patients,
	SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END) AS readmitted_patients,
	ROUND(
	100.0 *
	SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END)
	/ COUNT(*),
	2
	) AS readmission_rate
FROM diabetes_typed
GROUP BY number_inpatient;





--Emergency visits Vs Readmission
CREATE VIEW vw_emergency_readmission AS
SELECT
	number_emergency,
	COUNT(*) AS total_patient,
	SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END) AS readmitted_patient,
	ROUND(
	100.0 *
	SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END)
	/ COUNT(*),
	2
	) AS readmission_rate
FROM diabetes_typed
GROUP BY number_emergency;




--Number Diagnoses Vs Readmission

CREATE VIEW vw_diagnoses_readmission AS
SELECT
    number_diagnoses,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END) AS readmitted_patients,
    ROUND(
        100.0 *
        SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS readmission_rate
FROM diabetes_typed
GROUP BY number_diagnoses;




--A1CResults Vs Readmission

CREATE VIEW vw_a1c_readmission AS
SELECT
    A1Cresult,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END) AS readmitted_patients,
    ROUND(
        100.0 *
        SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS readmission_rate
FROM diabetes_typed
GROUP BY A1Cresult;
	



--Glucose Results Vs Readmission
CREATE VIEW vw_glucose_readmission AS
SELECT
    max_glu_serum,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END) AS readmitted_patients,
    ROUND(
        100.0 *
        SUM(CASE WHEN readmitted <> 'NO' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS readmission_rate
FROM diabetes_typed
GROUP BY max_glu_serum;



