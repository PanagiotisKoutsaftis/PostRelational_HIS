---------------------------------------------
--First we are going to create a new schema
--for our Hospital Information System (his)
---------------------------------------------

CREATE SCHEMA his
	AUTHORIZATION postgres;

--creating the basic tables for our system

CREATE TABLE his.Patients
(
	patient_code INT NOT NULL PRIMARY KEY,
	p_name VARCHAR(50) NOT NULL,
	p_surname VARCHAR(50) NOT NULL,
	father_name VARCHAR(50) DEFAULT NULL,
	tax_registration_number INT NOT NULL,
	date_of_birth DATE DEFAULT NULL
);

CREATE TABLE his.Social_Security_Institutes
(
	SSI_code INT NOT NULL PRIMARY KEY,
	Institute_name VARCHAR(50) NOT NULL,
	Immediate_insured_rate INT NOT NULL,
	Intermediate_insured_rate INT NOT NULL
);

CREATE TABLE his.Diagnoses
(
	diag_code VARCHAR(10) NOT NULL PRIMARY KEY,
	diag_Description VARCHAR(1000) NOT NULL,
	diag_type VARCHAR(10) NOT NULL
);

CREATE TABLE his.Lab_examinations
(
	LE_code VARCHAR(10) NOT NULL PRIMARY KEY,
	LE_name VARCHAR(100) NOT NULL,
	LE_normal_values VARCHAR(20) NOT NULL,
	LE_cost INT NOT NULL
);

-- creating data type lab so we can nest the lab exams per incident
-- in the incident table as an attribute with type lab

CREATE TYPE lab AS
(
	LE_code VARCHAR(10),
	LE_date DATE,
	LE_time TIME,
	LE_result VARCHAR(50)
);

CREATE TABLE his.Rad_examinations
(
	RE_code VARCHAR(10) NOT NULL PRIMARY KEY,
	RE_description VARCHAR(100) NOT NULL,
	RE_type VARCHAR(50) NOT NULL,
	RE_cost INT NOT NULL
);

-- creating data type rad so we can nest the rad exams per incident
-- in the incident table as an attribute with type rad

CREATE TYPE rad AS
(
	RE_code VARCHAR(10),
	RE_date DATE,
	RE_time TIME,
	RE_filepath VARCHAR(100)
);

CREATE TABLE his.doctors 
(
	doctor_code INT NOT NULL PRIMARY KEY,
	doctor_name VARCHAR(50) NOT NULL,
	doctor_surname VARCHAR(50) NOT NULL
);

CREATE TABLE his.Operations
(
	operation_code INT NOT NULL PRIMARY KEY,
	operation_name VARCHAR(50) NOT NULL,
	operation_cost INT NOT NULL
);

-- creating data type op so we can nest the operations per incident
-- in the incident table as an attribute with type op

CREATE TYPE op AS
(
	operation_code INT,
	IO_no INT,
	date_started DATE,
	time_started TIME,
	date_ended DATE,
	time_ended TIME,
	operation_doctors INT ARRAY --takes the doctor's code as an input
);

CREATE TABLE his.Incidents
(
	Incident_code INT NOT NULL PRIMARY KEY,
	patient_code INT NOT NULL REFERENCES his.Patients(patient_code),
	SSI_code INT REFERENCES his.Social_Security_Institutes(SSI_code),
	Diagnosis_code VARCHAR(10) REFERENCES his.Diagnoses(diag_code),
	date_started DATE NOT NULL,
	date_ended DATE,
	incident_doctors INT ARRAY, --takes the doctor's code as an input
	incident_lab_exams lab ARRAY,
	incident_rad_exams rad ARRAY,
	incident_operations op ARRAY
);

CREATE TABLE his.History_of_Kindred
(
	Kindred_code INT NOT NULL PRIMARY KEY,
	Kindred_name VARCHAR(50) NOT NULL,
	Kindred_surname VARCHAR(50) NOT NULL,
	patient_code INT NOT NULL REFERENCES his.Patients(patient_code)
);

CREATE TABLE his.Kindred_Surgeries
(
	Kindred_code INT NOT NULL REFERENCES his.History_of_Kindred(Kindred_code),
	operation_code INT NOT NULL REFERENCES his.Operations(operation_code),
	Frequency INT NOT NULL
);

CREATE TABLE his.Kindred_Diseases
(
	Kindred_code INT NOT NULL REFERENCES his.History_of_Kindred(Kindred_code),
	Diagnosis_code VARCHAR(10) NOT NULL REFERENCES his.Diagnoses(diag_code),
	diagnosis_date DATE NOT NULL
);

CREATE TABLE his.History_of_Surgeries
(
	patient_code INT NOT NULL REFERENCES his.Patients(patient_code),
	operation_code INT NOT NULL REFERENCES his.Operations(operation_code),
	date_performed DATE NOT NULL
);

CREATE TABLE his.History_of_Diseases
(
	patient_code INT NOT NULL REFERENCES his.Patients(patient_code),
	Diagnosis_code VARCHAR(10) NOT NULL REFERENCES his.Diagnoses(diag_code),
	diagnosis_date DATE NOT NULL
);

	