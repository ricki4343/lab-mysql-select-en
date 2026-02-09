USE pubs;

/*Challenge 1*/
SELECT 
	authors.au_id AS 'AUTHOR ID', 
    authors.au_lname AS 'LAST NAME', 
    authors.au_fname AS 'FIRST NAME', 
    titles.title AS 'TITLE', 
    publishers.pub_name AS 'PUBLISHER'
FROM authors
JOIN titleauthor
	ON authors.au_id = titleauthor.au_id
JOIN  titles
	ON titleauthor.title_id = titles.title_id
JOIN publishers
	ON titles.pub_id = publishers.pub_id
ORDER BY authors.au_id;


/*Challenge 2*/
SELECT 
	authors.au_id AS 'AUTHOR ID', 
    authors.au_lname AS 'LAST NAME', 
    authors.au_fname AS 'FIRST NAME',  
    publishers.pub_name AS 'PUBLISHER',
    COUNT(titles.title) AS 'TITLE COUNT'
FROM authors
JOIN titleauthor
	ON authors.au_id = titleauthor.au_id
JOIN  titles
	ON titleauthor.title_id = titles.title_id
JOIN publishers
	ON titles.pub_id = publishers.pub_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname, publishers.pub_name
ORDER BY COUNT(titles.title) DESC, authors.au_id DESC;

/*Challenge 3*/
SELECT 
	authors.au_id AS 'AUTHOR ID', 
    authors.au_lname AS 'LAST NAME', 
    authors.au_fname AS 'FIRST NAME', 
	SUM(sales.qty) AS 'TOTAL'
FROM authors
JOIN titleauthor
	ON authors.au_id = titleauthor.au_id
JOIN  titles
	ON titleauthor.title_id = titles.title_id
JOIN publishers
	ON titles.pub_id = publishers.pub_id
JOIN sales
	ON titles.title_id = sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY (SUM(sales.qty)) DESC
LIMIT 3;


/*Challenge 4*/
SELECT 
	authors.au_id AS 'AUTHOR ID', 
    authors.au_lname AS 'LAST NAME', 
    authors.au_fname AS 'FIRST NAME', 
	COALESCE(SUM(sales.qty), 0) AS 'TOTAL'
FROM authors
LEFT JOIN titleauthor
	ON authors.au_id = titleauthor.au_id
LEFT JOIN  titles
	ON titleauthor.title_id = titles.title_id
LEFT JOIN publishers
	ON titles.pub_id = publishers.pub_id
LEFT JOIN sales
	ON titles.title_id = sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY COALESCE(SUM(sales.qty), 0) DESC;