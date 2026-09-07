
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
SELECT count(owns.driver-id)
FROM owns 
join participated on participated.driver-id = owns.driver-id and participated.car-license = owns.car-license
join accident on accident.report-number = participated.report-number
WHERE accident.date >= '1-1-1989' and accident.date <='12-31-1989';



-- 1.2. Find the number of accidents in which the cars belonging to “John
-- Smith” were involved.
-- Getting a count of the persons name, with the table being formatted we
-- should only grab owns-person as these two both contain driver-id, then with
-- participated and acciddent we get the driver-id and the report-number only
-- getting the people named John smith into the equaiton

SELECT count(DISTINCT participated.accident-number) 
FROM person 
join participated on participated.driver-id = person.driver-id
join owns on owns.driver-id = person.driver-id
WHERE person.name = "John Smith";

-- 1.3. Add a new accident to the database; assume any values for required
-- attributes.
INSERT INTO accident (
  report-number, date, location
) VALUES ('123982', '09-01-2026', 'Edinburg,Texas')

-- 1.4. Delete the Mazda belonging to “John Smith”.

DELETE FROM car 
  WHERE car.model = 'Mazda' and car.car-license (SELECT owns.car-license
    FROM owns join person on person.driver-id = owns.driver-id WHERE
    person.name = 'John Smith';);

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
-- First step only select the empolyee.employee-name, then from this create a join table of employee-id with company-id 
SELECT e.employee-name FROM employee as e  
  join works as w on w.employee-id = e.employee-id 
  join company as c on c.company-id = w.company-id 
WHERE c.company-name = 'First Bank Corporation';


-- 2.2. Find the names and cities of residence of all employees who work for
-- First Bank Corporation.

SELECT e.employee-name, employee.city FROM employee as e  
  join works as w on w.employee-id = e.employee-id 
  join company as c on c.company-id = w.company-id 
WHERE c.company-name = 'First Bank Corporation';

-- 2.3. Find the names, street addresses, and cities of residence of all
-- employees who work for First Bank Corporation and earn more than
-- $10,000.

SELECT e.employee-name, e.street, employee.city FROM employee as e  
  join works as w on w.employee-id = e.employee-id 
  join company as c on c.company-id = w.company-id 
WHERE c.company-name = 'First Bank Corporation' and w.salary > 10,000;
-- 2.4. Find all employees in the database who live in the same cities as the
-- companies for which they work.
SELECT e.employee-name FROM employee as e 
JOIN works as w on w.employee-id = e.employee-id
JOIN compnay as c on c.company-id = w.company-id
WHERE e.city = c.city;
-- 2.5. Find all employees in the database who live in the same cities and
-- on the same streets as do their managers.

select e.employee-name from employee as e
join manages as m on m.employee-id = 


-- 2.6. Find all employees in the database who do not work for the First
-- Bank Corporation.

-- employee(employee-id, employee-name, street, city)
-- works(employee-id, company-id, salary)
-- company(company-id, company-name, city)
-- manages(employee-id, manager-id)
select e.employee-name from employee as e where employee-id 
  not in (select
  w.employee-id from works as w join company as c on c.company-id = w.company-id
  where c.company-name = 'First Bank Corporation');

-- 2.7. Find all employees in the database who earn more than each
-- employee of Small Bank Corporation.
-- Grab all the employee that are not in small bank corp then compare those employees with small corp payroll 

-- 2.8. Assume that the companies may be located in several cities. Find all
-- companies located in every city in which Small Bank Corporation is
-- located.
-- 2.9. Find all employees who earn more than the average salary of all
-- employees of their company.
-- 2.10. Find the company that has the most employees.
-- 2.11. Find the company that has the smallest payroll.
-- 2.12. Find those companies whose employees earn a higher salary, on
average, than the average of First Bank Corporation.
