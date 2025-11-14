CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    job_level INT,
    salary NUMERIC 
);

INSERT INTO employees (emp_name, job_level, salary) VALUES
('Alice Johnson', 1, 50000.00),
('Bob Smith', 2, 60000.00),
('Charlie Brown', 3, 75000.00),
('Diana Prince', 4, 90000.00),
('Ethan Hunt', 5, 120000.00);

SELECT * FROM employees; 

CREATE PROCEDURE adjust_salary(
    p_emp_id INT,
    OUT p_new_salary NUMERIC 
)

LANGUAGE plpgsql
AS $$
    DECLARE 
        v_job_level INT;
    BEGIN
        SELECT job_level INTO v_job_level 
        FROM employees WHERE emp_id = p_emp_id;
        IF v_job_level = 1 THEN
            UPDATE employees SET salary = salary*1.05
            WHERE emp_id = p_emp_id;
        ELSEIF v_job_level = 2 THEN 
            UPDATE employees SET salary = salary * 1.1 
            WHERE emp_id = p_emp_id;
        ELSEIF v_job_level =3 THEN 
            UPDATE employees SET salary = salary * 1.15
            WHERE emp_id = p_emp_id;
        ELSE 
            RAISE NOTICE 'This Job level is unchanged in the amount of salary';
        END IF; 
        	SELECT salary INTO p_new_salary FROM employees WHERE emp_id = p_emp_id;
    END;
$$;

DO 
$$
    DECLARE 
        result NUMERIC;
    BEGIN
        CALL adjust_salary(1,result);
        RAISE NOTICE 'The new salary of employee 01 is: %',result; 
    END; 
$$;