docker build -t vasilopo/multi-client:latest -t vasilopo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vasilopo/multi-server:latest -t vasilopo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vasilopo/multi-worker:latest -t vasilopo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vasilopo/multi-client:latest
docker push vasilopo/multi-server:latest
docker push vasilopo/multi-worker:latest

docker push vasilopo/multi-client:$SHA
docker push vasilopo/multi-server:$SHA
docker push vasilopo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vasilopo/multi-server:$SHA
kubectl set image deployments/client-deployment client=vasilopo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vasilopo/multi-worker:$SHA