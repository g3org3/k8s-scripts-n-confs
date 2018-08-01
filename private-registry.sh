DOCKER_SERVER=registry.jorgeadolfo.com
DOCKER_USERNAME=$1
DOCKER_PASSWORD=$2
DOCKER_EMAIL=7jagjag@gmail.com
kubectl create secret docker-registry regcred --docker-server=$DOCKER_SERVER --docker-username=$DOCKER_USERNAME --docker-password=$DOCKER_PASSWORD --docker-email=$DOCKER_EMAIL