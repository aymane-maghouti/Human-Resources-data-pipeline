-- create the HR table and then import the data manually 

create table HR (
id varchar(255),
first_name varchar(255),
last_name varchar(255),
birthdate varchar(255),
gender varchar(255),
race varchar(255),
department varchar(255),
jobtitle varchar(255),
location varchar(255),
hire_date varchar(255),
termdate varchar(255),
location_city varchar(255),
location_state varchar(255)
);


select * from hr;


------------------------------- PL/SQL Code -----------------------------------
-- renme the id column to emp_id
BEGIN
  EXECUTE IMMEDIATE 'ALTER TABLE hr RENAME COLUMN ID TO emp_id';
  COMMIT;
END;

-- This code processes each row in the "HR" table, checks the date format using regular expressions, and updates the "birthdate" column accordingly.
BEGIN
  FOR rec IN (SELECT * FROM hr WHERE birthdate IS NOT NULL) LOOP
    BEGIN
      IF REGEXP_LIKE(rec.birthdate, '\d{2}/\d{2}/\d{4}') THEN
        rec.birthdate := TO_DATE(rec.birthdate, 'MM/DD/YYYY');
      ELSIF REGEXP_LIKE(rec.birthdate, '\d{2}-\d{2}-\d{4}') THEN
        rec.birthdate := TO_DATE(rec.birthdate, 'MM-DD-YYYY');
      ELSE
        rec.birthdate := NULL;
      END IF;

      UPDATE hr SET birthdate = rec.birthdate WHERE CURRENT OF rec;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
  END LOOP;
  COMMIT;
END;

-- This code processes each row in the "hr" table, checks the date format using regular expressions, and updates the "hire_date" column accordingly.
BEGIN
  FOR rec IN (SELECT * FROM hr WHERE hire_date IS NOT NULL) LOOP
    BEGIN
      IF REGEXP_LIKE(rec.hire_date, '\d{2}/\d{2}/\d{4}') THEN
        rec.hire_date := TO_DATE(rec.hire_date, 'MM/DD/YYYY');
      ELSIF REGEXP_LIKE(rec.hire_date, '\d{2}-\d{2}-\d{4}') THEN
        rec.hire_date := TO_DATE(rec.hire_date, 'MM-DD-YYYY');
      ELSE
        rec.hire_date := NULL;
      END IF;

      UPDATE hr SET hire_date = rec.hire_date WHERE CURRENT OF rec;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
  END LOOP;
  COMMIT;
END;

-- This code processes each row in the "hr" table where "termdate" is not null and not an empty string and updates the "termdate" column with the specified date value.
BEGIN
  FOR rec IN (SELECT * FROM hr WHERE termdate IS NOT NULL AND termdate != ' ') LOOP
    BEGIN
      rec.termdate := TO_DATE('2029-10-29 06:09:38', 'YYYY-MM-DD HH24:MI:SS');
      UPDATE hr SET termdate = rec.termdate WHERE CURRENT OF rec;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
  END LOOP;
  COMMIT;
END;

-- add a new column 
BEGIN
  EXECUTE IMMEDIATE 'ALTER TABLE hr ADD age INT';
  COMMIT;
END;

--This code processes each row in the "hr" table where "birthdate" is not null, calculates the age based on the "birthdate," and updates the "age" column with the calculated age.
BEGIN
  FOR rec IN (SELECT * FROM hr WHERE birthdate IS NOT NULL) LOOP
    BEGIN
      rec.age := TRUNC(MONTHS_BETWEEN(SYSDATE, rec.birthdate) / 12);
      UPDATE hr SET age = rec.age WHERE CURRENT OF rec;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
  END LOOP;
  COMMIT;
END;

-------------------

select * from hr;




