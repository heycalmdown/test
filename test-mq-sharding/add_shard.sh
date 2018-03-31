docker-compose exec mq1 rabbitmqctl set_policy test-shard ^test$ '{"shards-per-node":4}'
curl -i -u guest:guest -H "content-type:application/json" \
    -XPUT -d'{"type":"x-modulus-hash","durable":false}' \
    http://localhost:15672/api/exchanges/%2f/test
