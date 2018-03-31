docker-compose exec mq1 rabbitmq-plugins enable rabbitmq_sharding
docker-compose exec mq2 rabbitmqctl stop_app
docker-compose exec mq2 rabbitmqctl join_cluster rabbit@mq1
docker-compose exec mq2 rabbitmqctl start_app
