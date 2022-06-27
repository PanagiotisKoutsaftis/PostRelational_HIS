----------------------------------------------
--question 3 part 1: inserting new patients
----------------------------------------------

-- INSERTING ONE PATIENT

INSERT INTO his.patients VALUES (1,'ΒΙΚΗ','ΖΑΡΙΚΟΥ','ΒΥΡΩΝ',123456789,'7/7/1983');

-- INSERTING MULTIPLE PATIENTS

INSERT INTO his.patients VALUES
(2,'ΙΩΑΝΝΑ','ΜΑΡΟΥΛΑΚΗ','ΚΥΡΙΑΚΟΣ',987654321,'15/1/1983'),
(3,'ΠΑΝΑΓΙΩΤΗΣ','ΜΟΝΙΤΑΚΗΣ','ΚΩΝΣΤΑΝΤΙΝΟΣ',555666444,'28/12/1984');


--------------------------------------------------------
--inserting some values we are goint to need for later
--------------------------------------------------------

-- inserting values in Social security institutes

INSERT INTO his.social_security_institutes VALUES
(1,'ΙΚΑ',20,15), (2,'ΟΓΑ',30,25), (3,'ΤΕΒΕ',24,22);

-- inserting values in Doctors

INSERT INTO his.doctors VALUES
(5,'ΝΙΚΟΣ','ΠΑΠΑΝΙΚΟΛΑΟΥ'),
(6,'ΓΕΩΡΓΙΟΣ','ΠΑΠΑΓΕΩΡΓΙΟΥ'),
(7, 'ΑΓΛΑΙΑ','ΚΥΡΙΑΚΟΥ'),
(8,'ΕΥΑΓΓΕΛΟΣ','ΠΑΠΑΕΥΑΓΓΕΛΟΥ'),
(9,'ΠΑΝΑΓΙΩΤΗΣ','ΠΑΠΑΠΑΝΑΓΙΩΤΟΥ'), 
(10,'ΔΗΜΗΤΡΗΣ','ΠΑΠΑΔΗΜΗΤΡΙΟΥ'),
(11,'ΚΛΕΙΩ','ΣΤΡΑΤΟΠΟΥΛΟΥ');


-- inserting values in lab examinations

INSERT INTO his.lab_examinations VALUES
('T3','Τριιωδοθυροδίνη','60-190 ng/dl',10),
('T4','Τετραϊωδοθυροδίνη-Θυροξίνη','4.5-12.5 μg/dl',10),
('TSH','Θυροειδοτρόπος ορμόνη','0.3-4.5 mlU/lt',14);

-- inserting values in rad examinations

INSERT INTO his.rad_examinations VALUES
('R7301','Υπερηχογράφημα Παγκρέατος','ΥΠΕΡΗΧΟΓΡΑΦΗΜΑ',20),
('R7304','Υπερηχογράφημα άνω κοιλίας','ΥΠΕΡΗΧΟΓΡΑΦΗΜΑ',28);

-- inserting values in operations

INSERT INTO his.operations VALUES 
(1,'Διουρηθρική Εκτομή Προστάτη',500),
(2,'Χολοκυστεκτομή',900),
(3,'Πλύση Στομάχου',120);

-- inserting values in diagnoses

INSERT INTO his.diagnoses VALUES
('K85.0','Ιδιοπαθής Οξεία παγκρεατίτιδα','ICD10'),
('K85.1','Χολική οξεία παγκρεατίτιδα(Παγκρεατίτιδα από χολόλιθο)','ICD10'),
('K85.2','Οξεία παγκρεατίτιδα οφειλόμενη στο οινόπνευμα','ICD10'),
('K85.3','Φαρμακευτική οξεία παγκρεατίτιδα','ICD10');

-------------------------------------------
--question 3 parts 11,12,13,14 and 15
-------------------------------------------

-- inserting values in history of surgeries for patient with code 2

INSERT INTO his.history_of_surgeries VALUES
(2,1,'6/2/2001'),
(2,3,'14/7/2003');

-- inserting values in history of diseases for patient with code 2

INSERT INTO his.history_of_diseases VALUES
(2,'K85.0','5/3/2000'),
(2,'K85.3','3/9/1999');

-- inserting values in history of kindred for patient with code 2

INSERT INTO his.history_of_kindred VALUES
(1,'ΚΥΡΙΑΚΟΣ','ΜΑΡΟΥΛΑΚΗΣ',2), --father
(2,'ΜΑΡΙΑ','ΜΑΡΟΥΛΑΚΗ',2), --mother
(3,'ΔΗΜΗΤΡΑ','ΜΑΡΟΥΛΑΚΗ',2); --sister

--inserting values in kindred surgeries

INSERT INTO his.kindred_surgeries VALUES
(1,2,2),
(1,3,1),
(3,2,1),
(2,3,2);

--inserting values in kindred diseases

INSERT INTO his.kindred_diseases VALUES
(1,'K85.0','3/3/1995'),
(2,'K85.3','15/9/1999'),
(3,'K85.2','28/7/2002');

-----------------------------------------------------
--question 3 part 2 and 3: inserting a new incident
-----------------------------------------------------

INSERT INTO his.incidents(incident_code,patient_code,date_started) VALUES
(8,2,'2/5/2005');

UPDATE his.incidents SET SSI_code = 1, diagnosis_code = 'K85.1', date_ended = '10/5/2005'
WHERE incident_code = 8;

------------------------------------------------------------------
--question 3 part 7 and 8: inserting the doctors of an incident
------------------------------------------------------------------

--first we must check the array length so we can insert the data to the correct place

SELECT array_length(incident_doctors,1) FROM his.incidents WHERE incident_code = 8;

--The first result is zero so we insert the value to index 1
UPDATE his.incidents SET incident_doctors[1] = 5 WHERE incident_code = 8;

--We check the length again before inserting
SELECT array_length(incident_doctors,1) FROM his.incidents WHERE incident_code = 8;

--The result is 1 so we insert the data to index 2
UPDATE his.incidents SET incident_doctors[2]=7 WHERE incident_code = 8;

----------------------------------------------
--question 3 part 4: inserting lab exams
----------------------------------------------

--First we must check the length of the lab_exam array before we insert data like we did above
SELECT array_length(incident_lab_exams,1) FROM his.incidents WHERE incident_code = 8;

--The first result is 0 so we insert the data to the index 1

UPDATE his.incidents SET incident_lab_exams[1] = ('T3','3/5/2005','8:50:00','90 ng/dl') 
WHERE incident_code = 8;

--We check the length again before inserting data
SELECT array_length(incident_lab_exams,1) FROM his.incidents WHERE incident_code = 8;

--The result is 1 so we insert the data to index 2
UPDATE his.incidents SET incident_lab_exams[2] = ('T4','3/5/2005','8:50:00','8.5 μg/dl')
WHERE incident_code = 8;

--We check the length again before inserting data
SELECT array_length(incident_lab_exams,1) FROM his.incidents WHERE incident_code = 8;

--The result is 2 so we insert the data to index 3
UPDATE his.incidents SET incident_lab_exams[3] = ('TSH','3/5/2005','8:50:00','2.5 mlU/lt')
WHERE incident_code = 8;

-----------------------------------------------
--question 3 part 5: inserting rad exams
-----------------------------------------------

--First we must check the length of the rad_exam array before we insert data like we did above
SELECT array_length(incident_rad_exams,1) FROM his.incidents WHERE incident_code = 8;

--The first result is 0 so we insert the data to the index 1

UPDATE his.incidents SET incident_rad_exams[1] = ('R7301','2/5/2005','17:00:00',' ') 
WHERE incident_code = 8;

--We check the length again before inserting data
SELECT array_length(incident_rad_exams,1) FROM his.incidents WHERE incident_code = 8;

--The result is 1 so we insert the data to index 2
UPDATE his.incidents SET incident_rad_exams[2] = ('R7304','2/5/2005','17:00:00',' ')
WHERE incident_code = 8;

------------------------------------------------------------------------------------
--question 3 part 6 and 9: inserting operations and doctors per incident operation
------------------------------------------------------------------------------------

--First we must check the length of the operations array before we insert data like we did above
SELECT array_length(incident_operations,1) FROM his.incidents WHERE incident_code = 8;

--The first result is 0 so we insert the data to the index 1

UPDATE his.incidents SET incident_operations[1] = (2,3,'3/5/2005','13:10:00','3/5/2005','14:30:00','{5,11}') 
WHERE incident_code = 8;
------------------------------------------------------------
--question 3 part 10: adding new doctors to an operation
------------------------------------------------------------

--first we must check the length of the operations doctors array before we insert data like we dis above
select array_length(incident_operations[1].operation_doctors,1) from his.incidents where incident_code = 8;

--we want to add a doctor to the first operation so the index of the operation array is 1 and
--the index of the operation_doctors is 3
UPDATE his.incidents SET incident_operations[1].operation_doctors[3] = 7 WHERE incident_code = 8;

--SOME SELECT STATEMENTS TO CHECK THE DATABASE
SELECT * FROM his.incidents;
SELECT incident_doctors FROM his.incidents;
SELECT incident_doctors[1] FROM his.incidents WHERE incident_code = 8;
SELECT incident_lab_exams FROM his.incidents;
SELECT incident_lab_exams[2] FROM his.incidents WHERE incident_code = 8;
SELECT incident_rad_exams FROM his.incidents;
SELECT incident_rad_exams[1] FROM his.incidents WHERE incident_code = 8;
SELECT incident_operations FROM his.incidents;
SELECT incident_operations[1] FROM his.incidents WHERE incident_code = 8;
SELECT incident_operations[1].operation_doctors FROM his.incidents WHERE incident_code = 8;
SELECT incident_operations[1].operation_doctors[2] FROM his.incidents WHERE incident_code = 8;