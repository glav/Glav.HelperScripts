@echo off
echo Staring Miscrosoft SQL Server Linux container
echo User: sa
echo Password: MyP@ssw0rd!

set SA_PASSWORD=MyP@ssw0rd!
cd %~dp0\LinuxSqlCompose
docker-compose up
echo Started with Password 'MyP@ssw0rd!'