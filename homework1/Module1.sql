
-- This is the relations table for the first part of the homework 
-- person(driver-id, name, address)
-- car(car-license, model, year)
-- accident(report-number, date, location)
-- owns(drive-id, car-license)
-- participated(driver-id, car-license, report-number, damage
-- amount)

-- 1.1. Find the total number of people who owned cars that were involved in
-- in an accident in 1989
-- distinct <rows.collumn> This will only display the user space.
SELECT COUNT(DISTINCT "driver-id")
FROM owns
WHERE ("driver-id", "car-license") IN (
  SELECT "driver-id", "car-license" 
  FROM participated 
  WHERE "report-number" IN (
    SELECT "report-number" 
    FROM accident
    WHERE date >= '1989-01-01' AND date <= '1989-12-31'
  )
);

-- 1.2. Find the number of accidents in which the cars belonging to “John
-- Smith” were involved.


SELECT COUNT(DISTINCT "report-number")
FROM  participated
WHERE ("car-license") in (
  SELECT "car-license" 
  FROM owns 
  WHERE "driver-id" in (
    SELECT "driver-id" 
    FROM  person 
    WHERE name = 'John Smith'
  )
);

-- 1.3. Add a new accident to the database; assume any values for required
-- attributes.
INSERT INTO accident("report-number", date, location)
VALUES ('96723423','2026-05-12','San Benito, Texas, 78586')

-- 1.4. Delete the Mazda belonging to “John Smith”.
DELETE FROM  car
WHERE model = 'mazda' AND "car-license" IN (
  SELECT "car-license" 
  FROM owns 
  WHERE "driver-id" IN (
    SELECT "driver-id" 
    FROM person 
    WHERE name = 'John Smith'));
-- 1.5. Update the damage amount for the car with license number
-- “AABB2000” in the accident with report number “AR2197” to $3000.

UPDATE participated
  SET damage-amount = 3000
  WHERE participated.car-license = 'AABB200' and participated.report-number='AR2197';




-- employee(employee-id, employee-name, street, city)
-- works(employee-id, company-id, salary)
-- company(company-id, company-name, city)
-- manages(employee-id, manager-id)


-- 2.1. Find the names of all employees who work for First Bank
-- Corporation.
SELECT "employee-name"
FROM employee
WHERE "employee-id" in (
  SELECT "employee-id"
  FROM works
  WHERE "company-id" IN (
    SELECT "company-id" 
    FROM company 
    WHERE "company-name" = 'First Bank Corporation'));


-- 2.2. Find the names and cities of residence of all employees who work for
-- First Bank Corporation.

SELECT "employee-name", city
FROM employee
WHERE "employee-id" in (
  SELECT "employee-id"
  FROM works
  WHERE "company-id" IN (
    SELECT "company-id" 
    FROM company 
    WHERE "company-name" = 'First Bank Corporation'));


-- 2.3. Find the names, street addresses, and cities of residence of all
-- employees who work for First Bank Corporation and earn more than
-- $10,000.

SELECT "employee-name", street, city
FROM employee
WHERE "employee-id" in (
  SELECT "employee-id"
  FROM works
  WHERE salary > 10000 and "company-id" IN (
    SELECT "company-id" 
    FROM company 
    WHERE "company-name" = 'First Bank Corporation'));

-- 2.4. Find all employees in the database who live in the same cities as the
-- companies for which they work.

SELECT "employee-name"
FROM employee
WHERE city IN (
  SELECT city 
  FROM company 
  WHERE "company-id" IN (
    SELECT "company-id" 
    FROM works 
    WHERE employee."employee-id" = works."employee-id"));

-- 2.5. Find all employees in the database who live in the same cities and
-- on the same streets as do their managers.
SELECT e."employee-name" 
FROM employee as e, employee as m, manages as mg 
WHERE e."employee-id" = mg."employee-id"
  AND m."employee-id" = mg."manager-id"
  AND e.street = m.street
  AND e.city = m.city;



-- 2.6. Find all employees in the database who do not work for the First
-- Bank Corporation.

SELECT "employee-name"
FROM employee 
WHERE "employee-id" NOT IN (
  SELECT "employee-id" 
  FROM works 
  WHERE "company-id" IN (
    SELECT "company-id" 
    FROM company 
    WHERE "company-name" = 'First Bank Corporation'));

-- employee(employee-id, employee-name, street, city)
-- works(employee-id, company-id, salary)
-- company(company-id, company-name, city)
-- manages(employee-id, manager-id)

-- 2.7. Find all employees in the database who earn more than each
-- employee of Small Bank Corporation.
SELECT "employee-name"
FROM employee 
WHERE "employee-id" IN (
  SELECT "employee-id" 
  FROM WORKS 
  WHERE salary > ALL (
    SELECT salary 
    FROM works 
    WHERE "company-id" IN (
      SELECT "company-id" 
      FROM company 
      WHERE "company-name" = "Small Bank Corporation")))
-- 2.8. Assume that the companies may be located in several cities. Find all
-- companies located in every city in which Small Bank Corporation is
-- located.
SELECT c."company-name"
FROM company as c
WHERE NOT EXISTS (
  SELECT sbc.city
  FROM company as sbc
  WHERE sbc."company-name" = 'Small Bank Corportaion'
    AND sbc.city NOT IN (
      SELECT c2.city
      FROM company as c2
      WHERE c2."company-name" = c."company-name"
    )
)
-- 2.9. Find all employees who earn more than the average salary of all
-- employees of their company.
SELECT e."employee-name"
FROM employee as e
join works as wEmp on wEmp."employee-id" = e."employee-id"
WHERE works.salary > (
  SELECT AVG(w.salary)
  FROM works as w
  WHERE  wEmp."company-id" = w."company-id"
);
-- 2.10. Find the company that has the most employees.
-- match company id with works, then just get distinct max count of employee-ids
SELECT c."company-name"
FROM  company as c 
WHERE c."company-id" in (
  SELECT "company-id" 
  FROM  works 
  GROUP BY "company-id" HAVING COUNT(DISTINCT "employee-id") >= ALL (
    SELECT COUNT (DISTINCT "employee-id") 
    FROM works 
    GROUP BY "company-id"));

-- 2.11. Find the company that has the smallest payroll.
SELECT c."company-name"
FROM company as c
JOIN works as wEmp on wEmp."company-id" = c."company-id"
GROUP BY c."company-id", c."company-name"
HAVING sum(wEmp.salary) <= ALL (
  SELECT SUM (salary)
  FROM works
  GROUP BY "company-id"
);
-- 2.12. Find those companies whose employees earn a higher salary, on
-- average, than the average of First Bank Corporation.
SELECT c."company-name"
FROM company as c
JOIN works as wHigh ON wHigh."company-id" = c."company-id"
GROUP BY c."company-id", c."company-name"
HAVING AVG(wHigh.salary) > (
  SELECT AVG(salary)
  FROM works
  WHERE "company-id" IN (SELECT "company-id" FROM company WHERE "company-name" = 'First Bank Corporation')
);

-- 3.1. Find the names of all employees who work for First Bank
-- Corporation.

-- 3.2. Find the names and cities of residence of all employees who work for
-- First Bank Corporation.

-- 3.3. Find the names, street addresses, and cities of residence of all
-- employees who work for First Bank Corporation and earn more than
-- $10,000.

-- 3.4. Find all employees in the database who live in the same cities as the
-- companies for which they work.

-- 3.5. Find all employees in the database who live in the same cities and
-- on the same streets as do their managers.

-- 3.6. Find all employees in the database who do not work for the First
-- Bank Corporation.

-- 3.7. Find all employees in the database who earn more than each
-- employee of Small Bank Corporation.

-- 3.8. Assume that the companies may be located in several cities. Find all
-- companies located in every city in which Small Bank Corporation is
-- located. 