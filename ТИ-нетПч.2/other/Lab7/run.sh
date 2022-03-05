export MYSQL_DATABASE="lab8"                 
export MYSQL_PASSWORD=password 
export MYSQL_USER=root  
export MYSQL_HOST=localhost:3306
docker run --name mysql \
    -e MYSQL_ROOT_PASSWORD=$MYSQL_PASSWORD \
    -e MYSQL_DATABASE="lab8" \
    -v data:/var/lib/mysql \
    -p 3306:3306 \
    -d mysql:latest

