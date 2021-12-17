# Java Quarkus Benchmark Client

## Requirements
* Java 11
* Maven 3.x
* Internet access to download needed artifacts

## Design notes
 * Configuration is defined in [application.properties](./src/main/resources/application.properties)

## Running the Database benchmark.

### Launching the application
```shell
mvn quarkus:dev
```

### Running the application by connecting to Mongo on Openshift

```shell
oc port-forward mongodb-benchmark-replica-set-0 34000:27017
mongo mongodb://developer:password@localhost:34000
```


### Building docker image and publish to quay.io

```shell
//adding the jib library so that we can build the docker image.
mvn quarkus:add-extension -Dextensions="container-image-jib"

//building the app to create docker image.
mvn clean package -Dquarkus.container-image.build=true

docker image tag lrangine/database-benchmark-client:1.0.0-SNAPSHOT quay.io/lrangine/database-benchmark-client:2.0.0-SNAPSHOT
docker image push quay.io/lrangine/database-benchmark-client:2.0.0-SNAPSHOT
```

### Running the benchmark

The client application exposes an API that can be used to start the test:
```properties
http://localhost:9090/benchmark/TYPE/DURATION/THREADS
```
Where:
* TYPE can be any of:
  * `databaseWrite`: Does write to the database mentioned as part of the JDBC URL. At this moment only mongo supported. 
  * `databaseRead`: Does read to the database mentioned as part of the JDBC URL. At this moment only mongo supported and reads the record with ID=1.
* DURATION is the duration in seconds of the test
* THREADS is the number of parallel threads to spawn



Examples:
```shell
 curl -X GET http://localhost:9090/benchmark/databaseWrite/120/3
```
Result is in JSON format:
```json
{
  "noOfExecutions" : 34135,
  "noOfFailures" : 0,
  "minResponseTime" : {
    "index" : 615,
    "responseTime" : 1
  },
  "maxResponseTime" : {
    "index" : 9144,
    "responseTime" : 80
  },
  "averageResponseTime" : 2,
  "percentile95" : 3,
  "percentile99" : 4,
  "totalTimeMillis" : 74882,
  "elapsedTimeMillis" : 30010,
  "requestsPerSecond" : 1137.0
}
```
**Note** The `index` attribute in `minResponseTime` and `maxResponseTime` respresent the (first) index of the request 
for which that time what calculated
