drop table census;
CREATE table census
(
	Year							VARCHAR(20),
	Industry_aggregation_NZSIOC		VARCHAR(20),
	Industry_code_NZSIOC			VARCHAR(20),
	Industry_name_NZSIOC			VARCHAR(100),
	Units							VARCHAR(20),
	Variable_code					VARCHAR(20),
	Variable_name					VARCHAR(100),
	Variable_category				VARCHAR(50),
	Value							VARCHAR(20),
	Industry_code_ANZSIC06			VARCHAR(200)
	);
TRUNCATE TABLE census;

	BULK INSERT 
	census
	FROM 'C:\Users\DELL\Documents\SQL Server Management Studio\ssms\provisional-csv.csv'
	WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR	= '\n'
	)

	SELECT * FROM census