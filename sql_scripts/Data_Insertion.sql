BULK INSERT order_details
FROM 'C:\Users\MY PC\Desktop'
WITH (
    FIELDTERMINATOR = ',',          -- delimiter between columns
    ROWTERMINATOR = '\n',          -- delimiter for each row
    FIRSTROW = 2                   -- skip header row if present
);
