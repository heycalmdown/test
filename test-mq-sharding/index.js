const amqp = require('amqplib');

function consumer(msg) {
	if (!msg) {
		console.log('channel has canceled');
		return;
	}
	console.log('exchange', msg.fields.exchange);
	console.log('rk', msg.fields.routingKey);
	console.log('payload', msg.content.toString('utf-8'));
}

async function connect(uri) {
	return amqp.connect(uri);
}


async function main() {
	const uris = ['amqp://localhost:5672', 'amqp://localhost:5673'];
	const conns = await Promise.all(uris.map(uri => connect(uri)));
	conns.map(async conn => {
		for (let i = 0; i < 8; i++) {
			const ch = await conn.createChannel();
			await ch.consume('test', function (msg) {
				consumer(msg);
				ch.ack(msg);
			});
		}
	});
}

main();

