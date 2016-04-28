--1. Function PreReqsFor(courseNum) - returns the immediate prerequisites 
--for the passed-in course number.

create or replace function PreReqsFor(INT, REFCURSOR) RETURNS REFCURSOR AS
$$
declare
   course      int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
      SELECT num, name
      FROM courses
      WHERE num in (SELECT prereqnum
                          FROM prerequisites
                          WHERE courseNum = course);
   return resultset;
end;
$$ 
language plpgsql;



select PreReqsFor(308, 'results');
Fetch all from results;

--2. Function IsPreReqFor(courseNum) - Returns the courses for which the 
--passed-in course number is an immediate prerequisite.

create or replace function IsPreReqFor(INT, REFCURSOR) RETURNS REFCURSOR AS
$$
declare
   course      int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
      SELECT num, name
      FROM courses
      WHERE num in (SELECT courseNum
                          FROM prerequisites
                          WHERE preReqNum = course);
   return resultset;
end;
$$ 
language plpgsql;



select IsPreReqFor(120, 'results');
Fetch all from results;





