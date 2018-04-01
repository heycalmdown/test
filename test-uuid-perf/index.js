function loop(times, func) {
	const result = [];
	for (let i = 0; i < times; ++i) {
		result.push(func());
	}
	return result;
}

function bson(times) {
	const b = require('bson');
	const oid = b.ObjectID;
	return loop(times, oid);
}

function bson_objectid(times) {
	const oid = require('bson-objectid');
	return loop(times, oid);
}

function mongodb(times) {
	const m = require('mongodb');
	const oid = m.ObjectID;
	return loop(times, oid);
}

function mongoose(times) {
	const m = require('mongoose');
	const oid = m.Types.ObjectId;
	return loop(times, oid);
}

function uuid(times) {
	const uuid = require('uuid');
	return loop(times, () => uuid.v4());
}

function nodeuuid(times) {
	const uuid = require('node-uuid');
	return loop(times, () => uuid.v4());
}

function benchmark(times, func) {
	console.time(func.name);
	func(times);
	console.timeEnd(func.name);
}

benchmark(10000, bson);
benchmark(10000, bson_objectid);
benchmark(10000, mongodb);
benchmark(10000, mongoose);
benchmark(10000, uuid);
benchmark(10000, nodeuuid);

