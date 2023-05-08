# kafka-connect-s3-without-topicname
TopiclessTimeBasedPartitioner

# Motivation: S3 Object Name
- I want to remove topicname(`<topic>`) from S3 Object Name when using S3 Sink Connector. S3 Sink Connector doesn't support it.
- Someone said I can use Blank(" "), Empty String(""), Back Space("\b") in `topic.dir` property of connector's config file. But it also doesn't work. `topic.dir` means just `<prefix>`.
```
# TimeBasedPartitioner
<prefix>/<topic>/<encodedPartition>/<topic>+<kafkaPartition>+<startOffset>.<format>
```
```
# TopiclessTimeBasedPartitioner
<prefix>/<encodedPartition>/<topic>+<kafkaPartition>+<startOffset>.<format>
```

# How to use
1. Download topicless-timebasedpartitioner.jar
2. Add the jar file into the connect plugin-path where the [S3 Sink Connector](https://www.confluent.io/hub/confluentinc/kafka-connect-s3) is already located.
    - The jar file does not contain the S3 sink connector, only the partitioner.
3. In your S3 sink connector configuration file, Write:
```
"partitioner.class": "io.github.yunanjeong.custom.TopiclessTimeBasedPartitioner"
```
# How to build sources (Maven)
- intelliJ 기준, jar 파일 (Artifact) 빌드 방법
    - `File-Project Structure` 진입
    - `Project Settings-Artifacts-Add(+)-Jar`에서 `Empty` 선택
        - `From modules with dependencies`를 선택하는 것이 일반적이지만, 이미 원본 S3 sink connector에 중복되는 dependency가 모두 있으므로 상관없음
    - `Name`에 Jar파일 이름을 적고, `Output Layout-Available Element`에서 'topicless-timebasedpartitioner' compile output만 jar파일 포함대상으로 선택
    - 이후 `intellij 메인 창-Build-Build Artifacts ...` 선택하여 빌드를 진행한다.
    - `{project root path}/out/` 에서 생성된 jar파일을 확인

- ubuntu cli 기준 빌드 방법
  ```
  # maven 설치
  sudo apt install mvn
  
  # 빌드
  mvn install -f pom.xml -Dcheckstyle.skip -DskipTests
  
  #{project root path}/target/에서 생성된 jar 파일 확인
  ```

# Reference
- [TimeBasedPartitioner 수정 로직](https://github.com/confluentinc/kafka-connect-storage-cloud/issues/321)
  - 로직 자체는 간단하지만 빌드 및 배포, kafka 적용 방법 등의 테스트가 필요해서 이 repository를 생성했다.
- [kafka-connect-storage-common(커넥트 공통코드)](https://github.com/confluentinc/kafka-connect-storage-common)
- [kafka-connect-storage-cloud(S3 Sink Connector 소스 코드)](https://github.com/confluentinc/kafka-connect-storage-cloud)
  - S3 Sink Connector는 커넥트 공통 코드를 라이브러리로 가져와 쓰고 있다.
- [실제 TimeBasedPartitioner의 로직은 커넥트 공통코드에 구현](https://github.com/confluentinc/kafka-connect-storage-common/tree/master/partitioner/src/main/java/io/confluent/connect/storage/partitioner)되어있다.
  - TimeBasedPartitioner는 DefaultPartitioner를 Override하고 있다.
  - Custom Partitioner는 기존 Partitioner를 Override해서 만들면 된다고 공식홈페이지에서 언급한다.
  - 현재는 TimeBasedPartitioner만 커스텀한 상태이나, 이와 같은 구조로 CustomPartitioner를 입맞에 맞게 만들 수 있다.
  - 따라서, 커스텀 작업은 개별 프로젝트 OR S3 Sink Connector 소스 코드 기반으로 하되, Override를하기 위한 원본로직 참고는 커넥트 공통코드에서 하면된다.
- 관련 코드는 모두 Maven프로젝트이며, pom.xml파일에 Maven Repository로부터 참조하는 Dependency가 기술된다.
