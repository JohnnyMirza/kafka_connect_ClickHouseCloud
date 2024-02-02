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
{ "cust_id": 123, "month": 9, "amount_paid":456.78 }
{ "cust_id": 124, "month": 9, "amount_paid":456.78 }
{ "cust_id": 125, "month": 9, "amount_paid":456.78 }
{ "cust_id": 126, "month": 9, "amount_paid":456.78 }
{ "cust_id": 126, "month": 9, "amount_paid":456.78 }
{ "cust_id": 128, "month": 9, "amount_paid":456.78 }
{ "cust_id": 123, "month": 9, "amount_paid":456.78 }
{ "cust_id": 123, "month": 9, "amount_paid":456.78 }
{ "cust_id": 123, "month": 9, "amount_paid":456.78 }
{ "cust_id": 123, "month": 9, "amount_paid":456.78 }
```
### From ClickHouse Cloud see the messages above apear
```
select * from test;
```

