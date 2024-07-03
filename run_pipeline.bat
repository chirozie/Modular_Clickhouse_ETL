@echo off

:: Define the logfile
set LOGFILE=pipeline_log.txt

:: log the start time
echo Running pipeline at %date% %time% >> %LOGFILE%

:: Run the main.py and log the output
C:\Users\ic\anaconda3\envs\chu\python.exe main.py >> %LOGFILE% 2>&1

:: log the end time
echo Pipeline completed at %date% %time% >> %LOGFILE%

echo. >> %LOGFILE%
