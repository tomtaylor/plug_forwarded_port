defmodule PlugForwardedPort.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :plug_forwarded_port,
      version: @version,
      elixir: "~> 1.8",
      name: "PlugForwardedPort",
      description: "Sets the Plug.Conn port from the X-Forwarded-Port HTTP header",
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package() do
    [
      licenses: ["MIT"],
      maintainers: ["Tom Taylor"],
      links: %{"GitHub" => "https://github.com/tomtaylor/plug_forwarded_port"}
    ]
  end

  defp deps do
    [
      {:plug, "~> 1.8"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
