const amqp = require('amqplib');

async function main() {
	const uris = ['amqp://localhost:5672', 'amqp://localhost:5673'];
	const conns = await Promise.all(uris.map(uri => amqp.connect(uri)));
	conns.map(async conn => {
		for (let i = 0; i < 4; i++) {
			const ch = await conn.createChannel();
			await ch.consume('test', function (msg) {
				consumer(msg, ch);
			});
		}
	});
}

function consumer(msg) {
	console.log('exchange', msg.fields.exchange);
	console.log('rk', msg.fields.routingKey);
	console.log('payload', msg.content.toString('utf-8'));
	ch.ack(msg);
}

main();

