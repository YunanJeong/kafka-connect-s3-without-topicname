USERNAME=yunanj
IMAGE=kafka-sinkcon
version=`cat VERSION.sinkcon`

URL_S3SINK=https://d1i4a15mxbxib1.cloudfront.net/api/plugins/confluentinc/kafka-connect-s3/versions/10.5.0/confluentinc-kafka-connect-s3-10.5.0.zip
URL_TOPICLESS=https://github.com/YunanJeong/kafka-connect-s3-without-topicname/releases/download/v10.5.0%2Bv1.0.0/topicless-timebasedpartitioner.jar

wget -P ./files/ $URL_S3SINK
wget -P ./files/ $URL_TOPICLESS

docker build -t $USERNAME/$IMAGE:latest -f Dockerfile.sinkcon .
docker tag $USERNAME/$IMAGE:latest $USERNAME/$IMAGE:latest
docker tag $USERNAME/$IMAGE:latest $USERNAME/$IMAGE:$version
docker push $USERNAME/$IMAGE:latest
docker push $USERNAME/$IMAGE:$version