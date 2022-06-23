export CLIENT_IMAGE="$DOCKER_USERNAME/multi-client"
export SERVER_IMAGE="$DOCKER_USERNAME/multi-server"
export WORKER_IMAGE="$DOCKER_USERNAME/multi-worker"
docker build --cache-from $CLIENT_IMAGE:latest -t $CLIENT_IMAGE:latest -t $CLIENT_IMAGE:$SHA -f ./client/Dockerfile ./client
docker build --cache-from $SERVER_IMAGE:latest -t $SERVER_IMAGE:latest -t $SERVER_IMAGE:$SHA -f ./server/Dockerfile ./server
docker build --cache-from $WORKER_IMAGE:latest -t $WORKER_IMAGE:latest -t $WORKER_IMAGE:$SHA -f ./worker/Dockerfile ./worker

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