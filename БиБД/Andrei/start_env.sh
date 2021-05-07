#!/bin/bash

# https://hub.docker.com/_/mysql


# # use mysqlcmd
docker exec $container sh -c 'exec mysqldump --all-databases -uroot -ppassword maindb $file'
docker exec $container sh -c '''for file in /tmp/*.sql; do mysql -uroot -ppassword maindb < $file; done'''


# # use sqlcmd
# docker exec -it $container /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'Newpassword_123'