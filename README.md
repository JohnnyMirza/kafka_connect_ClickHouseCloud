Confluent Kafka and Kafka Connect Sink to ClickHouse Cloud using Docker.

Edit the following **** in the scripts/startKafkaConnectComponents.sh.
- hostname (clickhouse cloud service address)
- topics (these will be mapped to a ClickHouse Table, ensure table is created first)
- Database
- Username
- Password


check logs for errors
-- docker-compose logs -f connect
