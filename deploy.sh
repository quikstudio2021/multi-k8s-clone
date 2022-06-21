docker build -t ymtangab/multi-client:latest -t ymtangab/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ymtangab/multi-server:latest -t ymtangab/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ymtangab/multi-worker:latest -t ymtangab/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ymtangab/multi-client:latest
docker push ymtangab/multi-server:latest
docker push ymtangab/multi-worker:latest

docker push ymtangab/multi-client:$SHA
docker push ymtangab/multi-server:$SHA
docker push ymtangab/multi-worker:$SHA

kubectl apply -f k8s/
kubectl set image deployment/server-deployment server=ymtangab/multi-server:$SHA
kubectl set image deployment/client-deployment server=ymtangab/multi-client:$SHA
kubectl set image deployment/worker-deployment server=ymtangab/multi-worker:$SHA