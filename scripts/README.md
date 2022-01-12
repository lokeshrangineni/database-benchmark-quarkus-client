# Running Benchmark for multiple users.

[runTheBenchmark.sh](./runTheBenchmark.sh) - This will let you run the benchmark client for multiple users in sequential way. You can modify the NUMBER_OF_USERS parameter (inside script) in case if we need to change it.

**Usage:**
```shell
./runTheBenchmark.sh [MONGO_DATABASE_POD_NAME]  [DATABASE_BENCHMARK_QUARKUS_CLIENT_POD_NAME]
```

**Example:**
```shell
./runTheBenchmark.sh mongodb-benchmark-replica-set-1  database-benchmark-quarkus-client-867485c897-kfdx2 > replicaset-aws-benchmark.log
```