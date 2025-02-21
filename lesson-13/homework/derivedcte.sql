CREATE TABLE TestMax (
    Year1 INT,
    Max1 INT,
    Max2 INT,
    Max3 INT
);

INSERT INTO TestMax (Year1, Max1, Max2, Max3)
VALUES 
    (2001, 10, 101, 87),
    (2002, 103, 19, 88),
    (2003, 21, 23, 89),
    (2004, 27, 28, 91);

SELECT * 
FROM TestMax


SELECT Year1, MAX(Value) AS MaxValue
FROM (
    SELECT Year1, Max1 AS Value FROM TestMax
    UNION
    SELECT Year1, Max2 AS Value FROM TestMax
    UNION
    SELECT Year1, Max3 AS Value FROM TestMax
) AS DerivedTable
GROUP BY Year1;
