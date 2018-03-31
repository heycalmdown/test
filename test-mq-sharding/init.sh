for i in {1..2}
do
	docker-compose exec mq$i rabbitmq-plugins enable rabbitmq_sharding
done
for i in {2..2}
do
	docker-compose exec mq$i rabbitmqctl stop_app
	docker-compose exec mq$i rabbitmqctl join_cluster rabbit@mq1
	docker-compose exec mq$i rabbitmqctl start_app
done

docker-compose exec mq1 rabbitmqctl set_policy qm '.*' '{"queue-master-locator":"min-masters"}'
docker-compose exec mq1 rabbitmqctl set_policy test-shard ^test$ '{"shards-per-node":4}'

curl -i -u guest:guest -H "content-type:application/json" \
    -XPUT -d'{"type":"x-modulus-hash","durable":false}' \
    http://localhost:15672/api/exchanges/%2f/test
