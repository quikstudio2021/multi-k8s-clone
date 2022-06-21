export CLIENT_IMAGE="$CLIENT_IMAGE"
export SERVER_IMAGE="$SERVER_IMAGE"
export WORKER_IMAGE="$WORKER_IMAGE"
docker build -t $CLIENT_IMAGE:latest -t $CLIENT_IMAGE:$SHA -f ./client/Dockerfile ./client
docker build -t $SERVER_IMAGE:latest -t $SERVER_IMAGE:$SHA -f ./server/Dockerfile ./server
docker build -t $WORKER_IMAGE:latest -t $WORKER_IMAGE:$SHA -f ./worker/Dockerfile ./worker

docker push $CLIENT_IMAGE:latest
docker push $SERVER_IMAGE:latest
docker push $WORKER_IMAGE:latest

docker push $CLIENT_IMAGE:$SHA
docker push $SERVER_IMAGE:$SHA
docker push $WORKER_IMAGE:$SHA

kubectl apply -f k8s/
kubectl set image deployment/client-deployment client=$CLIENT_IMAGE:$SHA
kubectl set image deployment/server-deployment server=$SERVER_IMAGE:$SHA
kubectl set image deployment/worker-deployment worker=$WORKER_IMAGE:$SHA