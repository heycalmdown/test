defmodule TestMix.MixProject do
  use Mix.Project

  def project do
    [
      app: :test_mix,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Consumer, []}
    ]
  end

  defp deps do
    [
      {:amqp, "~> 1.0"}
    ]
  end
end
