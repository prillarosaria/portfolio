SELECT * FROM orders_1 limit 5;
SELECT * FROM orders_2 limit 5;
SELECT * FROM customer limit 5;

# Total Penjualan dan Revenue pada Quarter-1 (Jan, Feb, Mar) dan Quarter-2 (Apr,Mei,Jun)
SELECT 
    SUM(quantity) as total_penjualan, 
    SUM(quantity*priceeach) as revenue 
FROM orders_1 
WHERE status = 'Shipped';
SELECT 
    SUM(quantity) as total_penjualan, 
    SUM(quantity*priceeach) as revenue 
FROM orders_2 
WHERE status = 'Shipped';

# Menghitung persentasi keseluruhan penjualan
SELECT 
	quarter,
	SUM(quantity) as total_penjualan,
	SUM(quantity * priceeach) as revenue
FROM
	(
	  SELECT 
	  	orderNumber, status, quantity, priceeach, '1' as quarter FROM orders_1
	  UNION
	  SELECT
	  	orderNumber, status, quantity, priceeach, '2' as quarter FROM orders_2
	) AS table_a
WHERE status = "Shipped"
GROUP BY quarter

# Apakah jumlah customers xyz.com semakin bertambah?
SELECT
	quarter,
	COUNT(DISTINCT customerID) as total_customers
FROM
	(SELECT
	customerID, createDate, QUARTER(createDate) as quarter
FROM customer
WHERE createDate >= "1 Januari 2004" AND createDate <= "30 Juni 2004") as tabel_b
GROUP BY quarter

# Seberapa banyak customers tersebut yang sudah melakukan transaksi?
SELECT
	quarter,
	COUNT(DISTINCT customerID) as total_customers
FROM
	(SELECT
	customerID, createDate, QUARTER(createDate) as quarter
FROM customer
WHERE createDate >= "1 Januari 2004" AND createDate <= "30 Juni 2004") as tabel_b
WHERE customerID IN (SELECT customerID FROM orders_1 UNION SELECT customerID FROM orders_2)
GROUP BY quarter

# Category produk apa saja yang paling banyak di-order oleh customers di Quarter-2?
SELECT 
    *
FROM
    (
        SELECT
            categoryid,
            COUNT(DISTINCT orderNumber) as total_order,
            SUM(quantity) as total_penjualan
        FROM
            (SELECT
                SUBSTRING(productCode, 1, 3) as categoryid,
                productCode, 
                orderNumber, 
                quantity, 
                status
            FROM orders_2
            WHERE status = "Shipped") as table_c
        GROUP BY categoryid
    ) as table_d
ORDER BY total_order DESC

# Seberapa banyak customers yang tetap aktif bertransaksi setelah transaksi pertamanya?
SELECT
    COUNT(DISTINCT customerID) as total_customers
FROM
    orders_1;
	
SELECT 
	"1" as quarter,
	COUNT(DISTINCT customerID)/25*100 as Q2
FROM orders_1
WHERE customerID IN (SELECT DISTINCT customerID FROM orders_2)
