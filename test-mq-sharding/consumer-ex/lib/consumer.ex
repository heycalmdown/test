defmodule Consumer do
  use GenServer
  use AMQP

  def start(_type, _args) do
    GenServer.start_link(__MODULE__, [], [])
  end

  def init(_opts) do
    list = for uri <- ["amqp://localhost:5672", "amqp://localhost:5673"], _ <- [1,2,3,4] do
      {:ok, conn} = Connection.open(uri)
      {:ok, chan} = Channel.open(conn)
      {:ok, consumer_tag} = Basic.consume(chan, "test")
      {consumer_tag, chan}
    end
    {:ok, Map.new(list)}
  end

  def handle_info({:basic_consume_ok, %{consumer_tag: _}}, map) do
    {:noreply, map}
  end

  def handle_info({:basic_deliver, payload, %{consumer_tag: ctag, delivery_tag: tag, exchange: ex, routing_key: rk}}, map) do
    IO.puts "exchange #{ex}"
    IO.puts "rk #{rk}"
    IO.puts "payload #{payload}"
    chan = map[ctag]
    :ok = Basic.ack chan, tag
    {:noreply, map}
  end
end
