/* 
Hospital Management System
Ryan Ondocin, Jimit Mistry
*/

/*
    DROP TABLE ROOM_INPATIENT;
    DROP TABLE APPOINTMENT;
    DROP TABLE DIAGNOSIS;
    DROP TABLE BILLING;
    DROP TABLE INPATIENT;
    DROP TABLE OUTPATIENT;
    DROP TABLE DOCTOR;
    DROP TABLE PATIENT;
    DROP TABLE ADMINISTRATION;
    DROP TABLE ROOM;
*/

CREATE TABLE ADMINISTRATION
(
    adminID INT NOT NULL PRIMARY KEY, -- primary key column
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(30) NOT NULL,
    phoneNo CHAR(10) NOT NULL,
    departmentName VARCHAR(100) CHECK( departmentName IN ('General Internal Medicine', 'Cardiology', 'Dermatology', 'Endocrinology', 'Gastroenterology', 'Oncology', 'Epidemiology', 'Nephrology', 'Pharmacology', 'Pulmonology', 'Rheumatology', 'ER')),
    officeNo VARCHAR(3)
    -- specify more columns here
);

CREATE TABLE DOCTOR
(
    doctorID INT NOT NULL PRIMARY KEY, -- primary key column
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(30) NOT NULL,
    departmentName VARCHAR(100) NOT NULL CHECK( departmentName IN ('General Internal Medicine', 'Cardiology', 'Dermatology', 'Endocrinology', 'Gastroenterology', 'Oncology', 'Epidemiology', 'Nephrology', 'Pharmacology', 'Pulmonology', 'Rheumatology', 'ER')),
    SSN CHAR(9) NOT NULL,
    yearsOfPractice NUMERIC DEFAULT 1,
    officeNo VARCHAR(3) NOT NULL,
    charge NUMERIC NOT NULL CHECK(charge > 0)-- A flat hourly rate, different for each doctor
);


CREATE TABLE PATIENT
(
    patientID INT NOT NULL PRIMARY KEY, -- primary key column
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(30) NOT NULL,
    DOB DATE NOT NULL DEFAULT GETDATE() CHECK(DOB <= GETDATE()),
    age NUMERIC NOT NULL CHECK(age >= 0),
    gender VARCHAR(2) NOT NULL CHECK(gender IN ('M', 'F', 'NA')), -- assigned at birth
    streetNo NUMERIC NOT NULL,
    streetName VARCHAR(100) NOT NULL,
    city VARCHAR(30) NOT NULL,
    stateName CHAR(2) NOT NULL, -- Two letter abbreviation for stateName
    zip NUMERIC(5) NOT NULL,
    phoneNo CHAR(10),
    doctorID INT NOT NULL,
    patientType CHAR(1) NOT NULL CHECK(patientType IN ('O','I')),
    patientHeight INT CHECK(patientHeight > 0), -- in centimeters (cm)
    patientWeight INT CHECK(patientWeight > 0), -- in pounds (lbs)

    CONSTRAINT patient_fk FOREIGN KEY (doctorID) REFERENCES DOCTOR(doctorID) 
);

CREATE TABLE APPOINTMENT
(
     appointmentID INT NOT NULL PRIMARY KEY,
     patientID INT NOT NULL,
     doctorID INT NOT NULL,
     adminID INT NOT NULL,
     appointmentDate DATE DEFAULT GETDATE() CHECK(appointmentDate < GETDATE()),

     CONSTRAINT appointment_fk1 FOREIGN KEY (doctorID) REFERENCES DOCTOR(doctorID),
     CONSTRAINT appointment_fk2 FOREIGN KEY (patientID) REFERENCES PATIENT(patientID),
     CONSTRAINT appointment_fk3 FOREIGN KEY (doctorID) REFERENCES ADMINISTRATION(adminID)
);

CREATE TABLE DIAGNOSIS
(
    diagnosisID INT NOT NULL PRIMARY KEY, -- primary key column
    doctorID INT NOT NULL,
    patientID INT NOT NULL,
    diagnosisCategory VARCHAR(100) NOT NULL CHECK(diagnosisCategory IN ('Hypertension','Hyperlipidemia','Diabetes','Back pain','Anxiety','Obesity','Allergic rhinitis','Reflux esophagitis','Respiratory problems','Hypothyroidism','Visual refractive errors','Osteoarthritis','Myositis','Pain in joint','Acute laryngopharyngitis','Acute maxillary sinusitis','Major depressive disorder','Acute bronchitis','Asthma','Skin Disease','Coronary atherosclerosis','Urinary tract infection','Influenza','Tuberculosis','Viral infection','Celiac Disease','Seizure Disorder','Cerebral Palsy','Tourette Syndrome','Attention Deficit Disorder','Down Syndrome','Crohns Disease')),
    diagnosis TEXT,
    diagnosisDate DATE NOT NULL CHECK(diagnosisDate <= GETDATE()),

    CONSTRAINT diagnosis_fk1 FOREIGN KEY (doctorID) REFERENCES DOCTOR(doctorID),
    CONSTRAINT diagnosis_fk2 FOREIGN KEY (patientID) REFERENCES PATIENT(patientID),
);

CREATE TABLE BILLING
(
    billingID INT NOT NULL PRIMARY KEY, -- primary key column
    patientID INT NOT NULL,
    doctorCharge NUMERIC NOT NULL DEFAULT 0, -- same as the rate of doctor
    prescriptionCharge NUMERIC NOT NULL DEFAULT 0, 
    roomCharge NUMERIC NOT NULL DEFAULT 0,
    insuranceCoveragePercentage NUMERIC(3) NOT NULL DEFAULT 0,
    billingDate DATE NOT NULL CHECK(billingDate >= GETDATE()),

    CONSTRAINT billing_fk FOREIGN KEY (patientID) REFERENCES PATIENT(patientID),
);

CREATE TABLE INPATIENT
(
    inpatientID INT NOT NULL PRIMARY KEY, -- primary key column
    admitDate DATE NOT NULL DEFAULT GETDATE() CHECK(admitDate <= GETDATE()),
    dischargeDate DATE NULL,

    CONSTRAINT inpatient_fk FOREIGN KEY (inpatientID) REFERENCES PATIENT(patientID),
);

CREATE TABLE OUTPATIENT
(
    outpatientID INT NOT NULL PRIMARY KEY, -- primary key column
    lastConsultDate DATE CHECK(lastConsultDate < GETDATE()),

    CONSTRAINT outpatient_fk FOREIGN KEY (outpatientID) REFERENCES PATIENT(patientID),
);

CREATE TABLE ROOM
(
    roomID INT NOT NULL PRIMARY KEY, -- primary key column
    roomStatus VARCHAR(10) NOT NULL CHECK(roomStatus IN ('Vacant', 'Occupied')),
    roomCharge NUMERIC NOT NULL CHECK(roomCharge > 0), -- charge per day
);

CREATE TABLE ROOM_INPATIENT
(
    inpatientID INT NOT NULL, -- primary key column
    roomID INT NOT NULL,

    CONSTRAINT room_inpatient_pk PRIMARY KEY (inpatientID,roomID),

    CONSTRAINT room_inpatient_fk1 FOREIGN KEY (inpatientID) REFERENCES INPATIENT(INpatientID),
    CONSTRAINT room_inpatient_fk2 FOREIGN KEY (roomID) REFERENCES ROOM(roomID),

);

--Insert Values into ADMINISTRATION Table
INSERT INTO ADMINISTRATION VALUES(1,'John', 'Dorian','1111111111','General Internal Medicine','112');
INSERT INTO ADMINISTRATION VALUES(2,'Elliot', 'Reid','2222222222','Cardiology','223');
INSERT INTO ADMINISTRATION VALUES(3,'Christopher', 'Turk','3333333333','Dermatology','334');
INSERT INTO ADMINISTRATION VALUES(4,'Percival', 'Cox','4444444444','Oncology','445');
INSERT INTO ADMINISTRATION VALUES(5,'Bob', 'Kelso','5555555555','Gastroenterology','556');
INSERT INTO ADMINISTRATION VALUES(6,'Todd', 'Quinlan','6666666666','Endocrinology','667');
INSERT INTO ADMINISTRATION VALUES(7,'John', 'Wen','7777777777','Pulmonology','778');
INSERT INTO ADMINISTRATION VALUES(8,'Keith', 'Dudemeister','8888888888','Pharmacology','889');
INSERT INTO ADMINISTRATION VALUES(9,'Molly', 'Clock','9999999999','Nephrology','990');

--Insert Values into DOCTOR Table
INSERT INTO doctor VALUES(1,'Susan', 'Grey','General Internal Medicine','111111111',10,'111',250);
INSERT INTO doctor VALUES(2,'Chris', 'Billinson','Cardiology','222222222',2,'222',300);
INSERT INTO doctor VALUES(3,'John', 'Noble','Dermatology','333333333',4,'333',125);
INSERT INTO doctor VALUES(4,'Beth', 'Rettinger','Oncology','444444444',7,'444',260);
INSERT INTO doctor VALUES(5,'Amy', 'Cote','Gastroenterology','555555555',1,'555',530);
INSERT INTO doctor VALUES(6,'Phil', 'Kinsella','Endocrinology','666666666',9,'666',120);
INSERT INTO doctor VALUES(7,'Patricia', 'Smith','Pulmonology','777777777',8,'777',550);
INSERT INTO doctor VALUES(8,'Jeffrey', 'Carpenter','Pharmacology','888888888',23,'888',400);
INSERT INTO doctor VALUES(9,'Amanda', 'Shock','Nephrology','999999999',1,'999',1000);

--Insert Values into PATIENT Table
INSERT INTO PATIENT VALUES(1,'Timothy', 'Gamble','1996-10-16',23,'M',123,'Cary Road','Manlius','NY',13104,'3153453651',1,'O',172,180);
INSERT INTO PATIENT VALUES(2,'Chris', 'Richards','1990-11-12',27,'M',234,'Bridge Avenue','Manlius','NY',13104,'3154256157',3,'I',150,164);
INSERT INTO PATIENT VALUES(3,'Chase', 'Roberts','1986-02-14',33,4,'M',345,'Lorraine Avenue','Syracuse','NY',16802,'6157267893',2,'O',144,220);
INSERT INTO PATIENT VALUES(4,'Nancy', 'Frechette','1964-01-19',55,'F',456,'Carrier Drive','Liverpool','NY',16803,'5152620092',5,'O',130,135);
INSERT INTO PATIENT VALUES(5,'Elvira', 'Robinson','2001-02-13',18,'F',567,'Taft Lane','Fayetteville','NY',22222,'1236728172',4,'I',190,240);
INSERT INTO PATIENT VALUES(6,'Lucy', 'Puro','2004-02-04',15,'F',678,'Barksdale Lane','Baldwinsville','NY',31215,'3334125263',6,'I',115,100);
INSERT INTO PATIENT VALUES(7,'Jamal', 'Badger','1997-07-21',22,'M',789,'Trillium Trail','Manlius','NY',13104,'4447267281',9,'I',156,145);
INSERT INTO PATIENT VALUES(8,'Rick', 'Carlton','1972-01-01',47,'M',890,'Parker Drive','Fayetteville','NY',22222,'7772891827',8,'I',174,210);
INSERT INTO PATIENT VALUES(9,'Sally', 'Baker','1952-04-20',67,'F',012,'Trout Road','Syracuse','NY',16802,'7268880290',7,'O',189,214);

--Insert Values into APPOINTMENT Table
INSERT INTO APPOINTMENT VALUES(100000001,1,1,9,'2019-09-08');
INSERT INTO APPOINTMENT VALUES(100000002,2,3,2,'2019-10-04');--
INSERT INTO APPOINTMENT VALUES(100000003,3,6,8,'2019-10-02');
INSERT INTO APPOINTMENT VALUES(100000004,4,5,3,'2019-04-06');
INSERT INTO APPOINTMENT VALUES(100000005,5,4,5,'2019-08-16');--
INSERT INTO APPOINTMENT VALUES(100000006,6,2,6,'2019-05-11');--
INSERT INTO APPOINTMENT VALUES(100000007,7,8,7,'2019-11-10');--
INSERT INTO APPOINTMENT VALUES(100000008,8,7,4,'2019-11-09');--
INSERT INTO APPOINTMENT VALUES(100000009,9,9,1,'2019-07-16');

--Insert Values into Diagnosis Table
INSERT INTO DIAGNOSIS VALUES(100000011,1,1,'Hypertension','High Systolic BP. High Salt Diet, must reduce and take ACE Inhibitors','2019-09-08');
INSERT INTO DIAGNOSIS VALUES(100000022,2,3,'Diabetes','Type II Diabetic, must reduce sugar and intake and take Insulin once daily','2019-10-05');
INSERT INTO DIAGNOSIS VALUES(100000033,3,2,'Back Pain','Fractured L3 Vertebrae, perscribed Oxycontin, recommended 30 mg / daily for one month','2019-10-04');
INSERT INTO DIAGNOSIS VALUES(100000044,4,5,'Anxiety','Reduced levels of Serotonin in the brain, perscribed Alazopram 0.5 mg for three months. Take as needed','2019-08-16');
INSERT INTO DIAGNOSIS VALUES(100000055,5,4,'Allergic rhinitis','Inflamed sinus, stuffy nose for 2 weeks. Take OTC Allegra, Benadryl or Claritin from local pharmacy','2019-04-07');
INSERT INTO DIAGNOSIS VALUES(100000066,6,6,'Obesity','Referred to Dietician. Must reduce sugar intake and exercise regularly','2019-05-11');
INSERT INTO DIAGNOSIS VALUES(100000077,7,9,'Hypothyroidism','Hyperactive thyroid leading to weight gain and lack of hunger. Take Levothyroxine: 10 mg/day for 3 months and schedule an additional appointment within the year.','2019-11-10');
INSERT INTO DIAGNOSIS VALUES(100000088,8,8,'Osteoarthritis','Joint Pain in left knee following lifting boxes. Take X-Ray of joint and increase Calcium intake','2019-11-09');
INSERT INTO DIAGNOSIS VALUES(100000099,9,7,'Acute bronchitis','Severe coughing fits. Prescribed inhaler from nearest pharmacy','2019-11-10');
--Insert Values into Billing Table
INSERT INTO BILLING VALUES(100000111,1,250,40,0,80,'2019-09-09');
INSERT INTO BILLING VALUES(100000222,2,125,400,100,60,'2019-10-06');--
INSERT INTO BILLING VALUES(100000333,3,300,80,0,40,'2019-10-06');
INSERT INTO BILLING VALUES(100000444,4,530,0,0,10,'2019-04-08');
INSERT INTO BILLING VALUES(100000555,5,260,90,100,0,'2019-08-18');--
INSERT INTO BILLING VALUES(100000666,6,120,0,100,55,'2019-05-13');--
INSERT INTO BILLING VALUES(100000777,7,1000,15,100,100,'2019-11-12');--
INSERT INTO BILLING VALUES(100000888,8,400,0,100,15,'2019-11-11');--
INSERT INTO BILLING VALUES(100000999,9,550,100,0,45,'2019-11-11');

--Insert Values into Inpatient Table
INSERT INTO INPATIENT VALUES(1,'2019-10-04','2019-10-05');--
INSERT INTO INPATIENT VALUES(2,'2019-08-16','2019-08-17');--
INSERT INTO INPATIENT VALUES(3,'2019-05-11','2019-05-12');--
INSERT INTO INPATIENT VALUES(4,'2019-11-10','2019-11-11');--
INSERT INTO INPATIENT VALUES(5,'2019-11-09','2019-11-10');--

--Insert Values into Outpatient Table 
INSERT INTO OUTPATIENT VALUES(1,'2019-09-08');--
INSERT INTO OUTPATIENT VALUES(2,'2019-10-02');--
INSERT INTO OUTPATIENT VALUES(3,'2019-04-06');--
INSERT INTO OUTPATIENT VALUES(4,'2019-07-16');--



--Insert Values into ROOM Table
INSERT INTO ROOM VALUES(1,'Vacant',100);
INSERT INTO ROOM VALUES(2,'Vacant',100);
INSERT INTO ROOM VALUES(3,'Vacant',100);
INSERT INTO ROOM VALUES(4,'Vacant',100);
INSERT INTO ROOM VALUES(5,'Vacant',100);
INSERT INTO ROOM VALUES(6,'Vacant',100);
INSERT INTO ROOM VALUES(7,'Vacant',100);
INSERT INTO ROOM VALUES(8,'Vacant',100);
INSERT INTO ROOM VALUES(9,'Vacant',100);
INSERT INTO ROOM VALUES(10,'Vacant',100);
INSERT INTO ROOM VALUES(11,'Vacant',100);
INSERT INTO ROOM VALUES(12,'Vacant',100);
INSERT INTO ROOM VALUES(13,'Vacant',100);
INSERT INTO ROOM VALUES(14,'Vacant',100);
INSERT INTO ROOM VALUES(15,'Vacant',100);
INSERT INTO ROOM VALUES(16,'Vacant',100);
INSERT INTO ROOM VALUES(17,'Vacant',100);
INSERT INTO ROOM VALUES(18,'Vacant',100);
INSERT INTO ROOM VALUES(19,'Vacant',100);
INSERT INTO ROOM VALUES(20,'Vacant',100);


--Insert Values into ROOM_INPATIENT Table 
INSERT INTO ROOM_INPATIENT VALUES(1,1);
INSERT INTO ROOM_INPATIENT VALUES(2,2);
INSERT INTO ROOM_INPATIENT VALUES(3,3);
INSERT INTO ROOM_INPATIENT VALUES(4,4);
INSERT INTO ROOM_INPATIENT VALUES(5,5);










