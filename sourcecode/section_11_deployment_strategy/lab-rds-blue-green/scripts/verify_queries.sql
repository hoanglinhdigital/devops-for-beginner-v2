-- Cac cau query dung trong lab RDS Blue/Green.
-- Mo trong MySQL Workbench, chay tung cau (Ctrl + Enter) tren ca connection BLUE va GREEN.

-- 1. Phien ban engine va trang thai read-only
SELECT @@version AS mysql_version, @@read_only AS read_only;

-- 2. Parameter group: BLUE (mysql80) = OFF, GREEN (mysql84) = ON
SHOW VARIABLES LIKE 'slow_query_log';

-- 3. So luong ban ghi - BLUE va GREEN phai bang nhau (du lieu duoc dong bo)
USE expense_db;
SELECT COUNT(*) AS total_transactions FROM `transaction`;
SELECT COUNT(*) AS total_sessions FROM `session`;

-- 4. 5 giao dich moi nhat - dung de kiem tra giao dich vua tao tren app da sang GREEN chua
SELECT id, type, amount, note, createdAt
FROM `transaction`
ORDER BY createdAt DESC
LIMIT 5;

-- 5. (Chi chay tren GREEN) Trang thai replication tu BLUE sang GREEN
--    Replica_IO_Running / Replica_SQL_Running = Yes, Seconds_Behind_Source ~ 0
SHOW REPLICA STATUS;

-- 6. (Chi chay tren GREEN) Thu ghi du lieu -> mong doi loi
--    ERROR 1290: The MySQL server is running with the --read-only option
UPDATE `user` SET name = 'test-write-green' WHERE email = 'demo@example.com';

-- 7. User dang dung plugin xac thuc nao (user tao tu 8.0 van giu mysql_native_password)
SELECT user, host, plugin FROM mysql.user WHERE user NOT LIKE 'rds%' AND user NOT LIKE 'mysql.%';
