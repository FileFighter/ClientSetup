docker cp /home/Bike2DH/ClientSetup/ReverseProxy/nginx.conf FileFighterReverseProxy:/etc/nginx/nginx.conf

docker network connect FileFighterNetwork sonarqube_sonarqube_1

docker stop FileFighterReverseProxy
docker start FileFighterReverseProxy