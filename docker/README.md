# 도커 컨테이너 생성용 디렉토리
쿠버네티스 등 사용시 S3 sink connector와 topiclesstimebasedpartitioner가 동시 적용된 Kafka Connect 컨테이너를 바로 사용할 수 있게 미리 만들어두기 위함

# 버전
- confluent hub의 S3 sink connector 10.5.0
- bitnami의 kafka 3.3.2

# How to Use
- 직접 빌드시
```
sudo chmod +x build_sinkcon.sh
sudo ./build_sinkcon.sh
```

- 도커허브 사용시
```
docker pull yunanj/kafka-sinkcon:latest
```

# 관련자료
- [alpaka](https://github.com/haje01/alpaka)
