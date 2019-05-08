/* Welcome to the SQL mini project. For this project, you will use
Springboard' online SQL platform, which you can log into through the
following link:

https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

Note that, if you need to, you can also download these tables locally.

In the mini project, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */



/* Q1: Some of the facilities charge a fee to members, but some do not.
Please list the names of the facilities that do. */
SELECT name FROM country_club.Facilities WHERE membercost > 0
Tennis Court 1
Tennis Court 2
Massage Room 1
Massage Room 2
Squash Court

/* Q2: How many facilities do not charge a fee to members? */
SELECT COUNT(facid) FROM country_club.Facilities WHERE membercost = 0

4

/* Q3: How can you produce a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost?
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */
SELECT facid, name, membercost, monthlymaintenance 
	FROM country_club.Facilities 
	WHERE membercost < 0.2*monthlymaintenance
	AND membercost > 0
facid	name			membercost	monthlymaintenance
	0	Tennis Court 1	5.0			200
	1	Tennis Court 2	5.0			200
	4	Massage Room 1	9.9			3000
	5	Massage Room 2	9.9			3000
	6	Squash Court	3.5			80
	
/* Q4: How can you retrieve the details of facilities with ID 1 and 5?
Write the query without using the OR operator. */
SELECT facid, name, membercost, monthlymaintenance
	FROM country_club.Facilities
	WHERE facid IN (1,5)
	
facid	name			membercost	monthlymaintenance	
1		Tennis Court 2	5.0			200
5		Massage Room 2	9.9			3000

/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */
SELECT name, monthlymaintenance,
	CASE WHEN monthlymaintenance > 100 THEN 'expensive'
	ELSE 'cheap' END AS expense
	FROM country_club.Facilities

	name			monthlymaintenance		expense
	Tennis Court 1	200						expensive
	Tennis Court 2	200						expensive
	Badminton Court	50						cheap
	Table Tennis	10						cheap
	Massage Room 1	3000					expensive
	Massage Room 2	3000					expensive
	Squash Court	80						cheap
	Snooker Table	15						cheap
	Pool Table		15						cheap

/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */
SELECT firstname, surname
	FROM country_club.Members
	WHERE joindate = 
		(SELECT MAX(joindate)
			FROM country_club.Members)
			
	firstname	surname	
	Darren		Smith			

/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */
SELECT DISTINCT CONCAT( firstname,  ' ', surname,  ' ', 
	(SELECT name
		FROM country_club.Facilities
		WHERE country_club.Facilities.facid = country_club.Bookings.facid) ) 
		AS  'Name and Court'
	FROM country_club.Members
	INNER JOIN country_club.Bookings 
	ON country_club.Members.memid = country_club.Bookings.memid
	WHERE country_club.Bookings.facid
	IN (SELECT facid
		FROM country_club.Facilities
		WHERE name LIKE  '%tennis court%')
	ORDER BY surname, firstname

	Name and Court	
	Florence Bader Tennis Court 1
	Florence Bader Tennis Court 2
	Anne Baker Tennis Court 2
	Anne Baker Tennis Court 1
	Timothy Baker Tennis Court 1
	Timothy Baker Tennis Court 2
	Tim Boothe Tennis Court 2
	Tim Boothe Tennis Court 1
	Gerald Butters Tennis Court 2
	Gerald Butters Tennis Court 1
	Joan Coplin Tennis Court 1
	Erica Crumpet Tennis Court 1
	Nancy Dare Tennis Court 1
	Nancy Dare Tennis Court 2
	David Farrell Tennis Court 1
	David Farrell Tennis Court 2
	Jemima Farrell Tennis Court 1
	Jemima Farrell Tennis Court 2
	Matthew Genting Tennis Court 1
	GUEST GUEST Tennis Court 1
	GUEST GUEST Tennis Court 2
	John Hunt Tennis Court 2
	John Hunt Tennis Court 1
	David Jones Tennis Court 1
	David Jones Tennis Court 2
	Douglas Jones Tennis Court 1
	Janice Joplette Tennis Court 2
	Janice Joplette Tennis Court 1
	Charles Owen Tennis Court 1
	Charles Owen Tennis Court 2
	David Pinker Tennis Court 1
	Millicent Purview Tennis Court 2
	Tim Rownam Tennis Court 1
	Tim Rownam Tennis Court 2
	Henrietta Rumney Tennis Court 2
	Ramnaresh Sarwin Tennis Court 1
	Ramnaresh Sarwin Tennis Court 2
	Darren Smith Tennis Court 2
	Jack Smith Tennis Court 2
	Jack Smith Tennis Court 1
	Tracy Smith Tennis Court 2
	Tracy Smith Tennis Court 1
	Ponder Stibbons Tennis Court 1
	Ponder Stibbons Tennis Court 2
	Burton Tracy Tennis Court 1
	Burton Tracy Tennis Court 2
	
/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */
SELECT name AS 'Facility', CONCAT(firstname,' ', surname) AS 'Name', SUM(slots*(
	CASE WHEN country_club.Bookings.memid = 0 THEN guestcost 
    ELSE membercost END)) AS Cost

	FROM country_club.Bookings
	JOIN country_club.Facilities
	ON country_club.Bookings.facid = country_club.Facilities.facid
	
	JOIN country_club.Members
	ON country_club.Bookings.memid = country_club.Members.memid
	
	WHERE starttime BETWEEN '2012-09-14 00:00:00' AND '2012-09-14 23:59:59'
	GROUP BY country_club.Bookings.memid
	HAVING Cost>30
	ORDER BY Cost

	Facility			Name			Cost	
	Tennis Court 1		Burton Tracy	34.8
	Massage Room 1		Jemima Farrell	59.4
	Tennis Court 1		GUEST GUEST		1315.0
	


/* Q9: This time, produce the same result as in Q8, but using a subquery. */
SELECT name AS 'Facility', CONCAT(firstname,' ', surname) AS 'Name', SUM(slots*(
	CASE WHEN country_club.Bookings.memid = 0 THEN guestcost 
    ELSE membercost END)) AS Cost

	FROM country_club.Bookings
	JOIN country_club.Facilities
	ON country_club.Bookings.facid = country_club.Facilities.facid
	
	JOIN country_club.Members
	ON country_club.Bookings.memid = country_club.Members.memid
	
	WHERE starttime IN (SELECT starttime 
                        	FROM country_club.Bookings
         					WHERE starttime LIKE '2012-09-14%')

	GROUP BY country_club.Bookings.memid
	HAVING Cost>30
	ORDER BY Cost

	Facility			Name			Cost	
	Tennis Court 1		Burton Tracy	34.8
	Massage Room 1		Jemima Farrell	59.4
	Tennis Court 1		GUEST GUEST		1315.0
	
/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */
SELECT 	name AS 'Facility',
		SUM(slots*(CASE WHEN country_club.Bookings.memid = 0 THEN guestcost 
    		ELSE membercost END)) AS TotalRevenue

	FROM country_club.Bookings
	JOIN country_club.Facilities
	ON country_club.Bookings.facid = country_club.Facilities.facid

	GROUP BY country_club.Bookings.facid
	HAVING TotalRevenue <1000
	ORDER BY TotalRevenue
	
	Facility		TotalRevenue	
	Table Tennis	180.0
	Snooker Table	240.0
	Pool Table		270.0