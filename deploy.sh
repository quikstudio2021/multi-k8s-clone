docker build -t ymtangab/multi-client -f ./client/Dockerfile ./client
docker build -t ymtangab/multi-server -f ./server/Dockerfile ./server
docker build -t ymtangab/multi-worker -f ./worker/Dockerfile ./worker
docker push ymtangab/multi-client
docker push ymtangab/multi-server
docker push ymtangab/multi-worker