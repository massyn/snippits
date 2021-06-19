-- Setup the basic table
CREATE TABLE ratings (
	item VARCHAR(20),
	rating INTEGER
);

-- Load some raw data
INSERT INTO ratings (item,rating) VALUES('A','5');
INSERT INTO ratings (item,rating) VALUES('B','4');
INSERT INTO ratings (item,rating) VALUES('C','3');
INSERT INTO ratings (item,rating) VALUES('D','2');
INSERT INTO ratings (item,rating) VALUES('E','1');
INSERT INTO ratings (item,rating) VALUES('A','2');
INSERT INTO ratings (item,rating) VALUES('B','2');
INSERT INTO ratings (item,rating) VALUES('C','5');
INSERT INTO ratings (item,rating) VALUES('D','5');
INSERT INTO ratings (item,rating) VALUES('E','3');
INSERT INTO ratings (item,rating) VALUES('A','2');
INSERT INTO ratings (item,rating) VALUES('B','2');
INSERT INTO ratings (item,rating) VALUES('C','3');

-- Calculate the rating
SELECT
		Q2.item,
		Q2.this_rating,
		Q2.this_num_votes,
		Q2.avg_rating,
		Q2.avg_num_votes,
		( (Q2.avg_num_votes * Q2.avg_rating) + (Q2.this_num_votes * Q2.this_rating) ) / (Q2.avg_num_votes + Q2.this_num_votes) as 'bayesian average'
FROM
(
	SELECT
		Q1.item,
		Q1.this_rating,
		Q1.this_num_votes,
		AVG(Q1.this_rating) OVER() as 'avg_rating',
		AVG(Q1.this_num_votes) OVER() as 'avg_num_votes'
	FROM
	(
		SELECT 
			R.item,
			avg(R.rating) as 'this_rating',
			count(*) as 'this_num_votes'
		FROM ratings R
		GROUP BY
			R.item		
	) AS Q1
) AS Q2
