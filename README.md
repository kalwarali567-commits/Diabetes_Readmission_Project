# Diabetes_Readmission_Project

# Diabetes Readmission Analysis for Small Clinics

## Project Overview

This project analyzes diabetic patient readmissions to identify high-risk patient groups and provide actionable recommendations for small clinics. The goal is to help healthcare providers prioritize follow-up care, improve chronic disease management, and reduce preventable readmissions.

## Business Problem

Small clinics often operate with limited staff and resources while managing a growing number of diabetic patients. Frequent readmissions increase workload, reduce operational efficiency, and place additional strain on healthcare teams.

This project answers the question:

**Which diabetic patients are most likely to be readmitted, and how can clinics proactively reduce that risk?**

## Dataset

* 101,766 patient encounters
* Demographic information
* Admission and discharge information
* Diabetes medication data
* Laboratory test results
* Readmission status

## Project Workflow

### 1. Data Audit

* Missing value assessment
* Duplicate validation
* Data quality review
* Data type assessment

### 2. Data Preparation

* Removed non-essential columns
* Standardized data types
* Created analysis-ready dataset
* Built SQL views for reporting

### 3. Exploratory Data Analysis

Analyzed relationships between readmissions and:

* Age
* Previous inpatient visits
* Emergency visits
* Number of diagnoses
* Diabetes medication usage
* A1C results
* Glucose results

### 4. Key Findings

Patients aged 70–90 showed the highest readmission burden.
Prior inpatient admissions were associated with increased readmission risk.
Patients with multiple diagnoses represented a large share of readmissions.
Missing A1C monitoring was associated with higher readmission rates.
Missing glucose monitoring was associated with higher readmission rates.

### 5. Recommendations

* Create a high-risk patient registry.
* Implement structured post-discharge follow-up.
* Strengthen chronic disease management programs.
* Improve A1C monitoring compliance.
* Prioritize elderly diabetic patients for proactive care coordination.

## Dashboard

The Power BI dashboard provides:

* Readmission overview metrics
* High-risk patient indicators
* Readmission driver analysis
* Monitoring insights
* Actionable recommendations

## Tools Used

* SQL
* Power BI
* Excel

## Business Impact

This analysis demonstrates how healthcare analytics can help small clinics identify high-risk diabetic patients, allocate resources more effectively, and support proactive intervention strategies to reduce avoidable readmissions.
