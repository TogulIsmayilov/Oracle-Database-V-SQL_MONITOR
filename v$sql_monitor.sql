V$SQL_MONITOR-a baxanda məqsədin bir dənədir:

Hazırda sistemi yoran SQL-i tutmaq



SELECT sql_id,
       sql_text,
       status,
       elapsed_time/1e6 elapsed_sec,
       buffer_gets,
       disk_reads,
       sql_exec_start
FROM v$sql_monitor
ORDER BY elapsed_time DESC;




--Currently running requests:
SELECT sql_id, username, status,
       ROUND(elapsed_time/1000000, 2) elapsed_sec,
       ROUND(cpu_time/1000000, 2) cpu_sec,
       sql_text
FROM v$sql_monitor
WHERE status = 'EXECUTING'
ORDER BY elapsed_time DESC;



--the most CPU:
SELECT sql_id, username,
       ROUND(cpu_time/1000000, 2) cpu_sec,
       ROUND(elapsed_time/1000000, 2) elapsed_sec,
       sql_text
FROM v$sql_monitor
WHERE status = 'DONE'
ORDER BY cpu_time DESC
FETCH FIRST 10 ROWS ONLY;



--Top disk read
SELECT sql_id, username,
       disk_reads,
       buffer_gets,
       ROUND(elapsed_time/1000000, 2) elapsed_sec,
       sql_text
FROM v$sql_monitor
ORDER BY disk_reads DESC
FETCH FIRST 10 ROWS ONLY;



--Report
SET LONG 1000000
SET LONGCHUNKSIZE 1000000
SET LINESIZE 300
SET PAGESIZE 0

SELECT DBMS_SQLTUNE.REPORT_SQL_MONITOR(
    sql_id => '<sql_id>',
    type   => 'TEXT'
) FROM dual;




SET LONG 1000000
SET LONGCHUNKSIZE 1000000
SET LINESIZE 300
SET PAGESIZE 0

SELECT DBMS_SQLTUNE.REPORT_SQL_MONITOR(
    sql_id => '<4djw12tvp6836>',
    type   => 'TEXT'
) FROM dual;






