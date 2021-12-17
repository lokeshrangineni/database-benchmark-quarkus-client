#!/bin/sh

# Example run
# ./runTheBenchmark.sh mongodb-benchmark-replica-set-1  database-benchmark-quarkus-client-867485c897-kfdx2

MONGO_POD_NAME=$1   # Mongo Pod Name from Open Shift Cluster
BENCHMARK_CLIENT_POD_NAME=$2
NUMBER_OF_USERS="1 4 8 20 40 60 80 100 120 160 200"

echo "Current date : $(date) @ $(hostname)"

# Iterate the string variable using for loop
for USER in $NUMBER_OF_USERS; do
    echo "------------------------------------------"
    printf "\n Running test for number of users - %s \n" $USER

    printf "Delete the existing mongo database collection \n"
    ./delete-existing-collection.sh $MONGO_POD_NAME

    printf "\nTriggering the warm up benchmark in %s \n" $BENCHMARK_CLIENT_POD_NAME
    printf "curl -X GET http://localhost:9090/benchmark/databaseWrite/20/30 \n"
    # Trigger the test request
    oc exec $BENCHMARK_CLIENT_POD_NAME -- /bin/sh -c "curl -X GET http://localhost:9090/benchmark/databaseWrite/20/30"

     printf "\nTriggering the actual benchmark in %s \n" $BENCHMARK_CLIENT_POD_NAME
     printf "curl -X GET http://localhost:9090/benchmark/databaseWrite/30/%s \n" $USER
     oc exec $BENCHMARK_CLIENT_POD_NAME -- /bin/sh -c "curl -X GET http://localhost:9090/benchmark/databaseWrite/120/$USER"

    echo "------------------------------------------"
done