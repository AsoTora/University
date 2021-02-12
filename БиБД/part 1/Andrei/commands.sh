#!/bin/bash

# start sqlcmd
docker exec -it $container /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'Newpassword_123'