@echo off
echo Staring Miscrosoft SQL Server Linux container

set SA_PASSWORD=MyP@ssw0rd!
cd %~dp0\LinuxSqlCompose
docker-compose up
echo Started with Password 'MyP@ssw0rd!'