# SHA so you can make sure netes will update it's cluster with the latest stuff
docker build -t betauser001/multi-client:latest -t betauser001/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t betauser001/multi-server:latest -t betauser001/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t betauser001/multi-worker:latest -t betauser001/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push betauser001/multi-client
docker push betauser001/multi-server
docker push betauser001/multi-worker

docker push betauser001/multi-client:$SHA
docker push betauser001/multi-server:$SHA
docker push betauser001/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=betauser001/multi-server:$SHA
kubectl set image deployments/client-deployment client=betauser001/multi-client:$SHA
# worker= -> worker container
kubectl set image deployments/worker-deployment worker=betauser001/multi-worker:$SHA
