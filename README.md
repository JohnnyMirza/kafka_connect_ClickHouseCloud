# Confluent Kafka and Kafka Connect Sink to ClickHouse Cloud using Docker.

## Edit the following **** in the scripts/startKafkaConnectComponents.sh.
```
- hostname (clickhouse cloud service address)
- topics (these will be mapped to a ClickHouse Table, ensure table is created first)
- Database
- Username
- Password
```

### Start Instance
```
docker-compose up -d
```

### check logs for errors
```
-compose logs -f connect
```

-----------------------------------------------------------------------
## To test:

### Create 'test' Table in ClickHouse Cloud:
```
CREATE TABLE test
(
    cust_id UInt32,
    month UInt8,
    amount_paid Float64
)
ORDER BY cust_id;
```
### Insert messages into Kafka
```
docker exec broker kafka-console-producer --bootstrap-server localhost:9092 --topic test
(or
docker exec -it broker bash
kafka-console-producer --bootstrap-server localhost:9092 --topic test
)

{ "cust_id": 123, "month": 9, "amount_paid": 1456.78 }
{ "cust_id": 124, "month": 94, "amount_paid": 2456.78 }
{ "cust_id": 125, "month": 91, "amount_paid": 3456.78 }
{ "cust_id": 126, "month": 99, "amount_paid": 4456.78 }
{ "cust_id": 127, "month": 97, "amount_paid": 5456.78 }
{ "cust_id": 128, "month": 92, "amount_paid": 6456.78 }
{ "cust_id": 129, "month": 95, "amount_paid": 7456.78 }
{ "cust_id": 130, "month": 94, "amount_paid": 8456.78 }
{ "cust_id": 131, "month": 92, "amount_paid": 9456.78 }
{ "cust_id": 132, "month": 90, "amount_paid": 1156.78 }
```
### From ClickHouse Cloud see the messages above apear
```
select * from test;
```

