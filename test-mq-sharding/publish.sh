for i in {0..15}
do
	curl -i -u guest:guest -H "content-type:application/json" \
	    -XPOST -d"{\"properties\":{},\"routing_key\":\"$i\",\"payload\":\"blahblah\",\"payload_encoding\":\"string\"}" \
	    http://localhost:15672/api/exchanges/%2f/test/publish
done
