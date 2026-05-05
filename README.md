**Oracle V$SQL_MONITOR**

Oracle Database V$SQL_MONITOR is a real-time performance monitoring view used to track the execution of SQL statements.
It helps DBAs and developers see how a SQL query is performing while it is running or just after it finishes.


________________________________________
**What is V$SQL_MONITOR?**
V$SQL_MONITOR provides live execution statistics for SQL statements that Oracle decides to monitor automatically (usually long-running or resource-intensive queries).
In simple terms:
It answers: “Which SQL is running, how long is it taking, and where is it slow?”
________________________________________
**Main Purpose**
•	Monitor long-running SQL statements 
•	Identify performance bottlenecks in real time 
•	Analyze CPU, I/O, and memory usage per SQL 
•	Help troubleshoot slow queries instantly 
•	Compare execution efficiency 
________________________________________
**Key Information Provided**

**SQL Identification**
•	SQL_ID → Unique identifier of the SQL statement 
•	STATUS → Running, Done, or Queued 

**Performance Metrics**
•	ELAPSED_TIME → Total execution time 
•	CPU_TIME → CPU usage time 
•	BUFFER_GETS → Logical reads (memory access) 
•	DISK_READS → Physical reads (disk access) 
Execution Details
•	SQL_EXEC_START → Start time of execution 
•	USERNAME / USER_ID → Who executed it 
________________________________________
**When Does Oracle Use It?**
Oracle does NOT monitor every SQL.
It activates monitoring when:
•	Query runs longer than a threshold (usually few seconds) 
•	Parallel execution is used 
•	SQL is resource-intensive 
•	Explicit hint is added: /*+ MONITOR */ 
________________________________________
**Example Query**
SELECT
    sql_id,
    status,
    elapsed_time/1e6 AS elapsed_sec,
    cpu_time/1e6 AS cpu_sec,
    buffer_gets,
    disk_reads,
    sql_exec_start
FROM v$sql_monitor
ORDER BY elapsed_time DESC;
________________________________________
**Important Notes**
•	It shows real-time or recent executions only 
•	Not a full history of all SQLs 
•	Best used for troubleshooting slow queries 
•	Very useful for performance tuning and debugging 
________________________________________
**Summary**
V$SQL_MONITOR is a powerful real-time SQL performance analysis tool in Oracle Database used to detect and diagnose slow or resource-heavy queries during execution.

