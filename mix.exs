defmodule Exowm.Mixfile do
  use Mix.Project

  def project do
    [app: :exowm,
      version: "0.0.1",
      elixir: "~> 1.0",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      name: Exowm,
      source_url: "https://github.com/svarlet/exowm",
      homepage_url: "https://github.com/svarlet/exowm",
      deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.8", only: :dev},
      {:mix_test_watch, "~> 0.1.2", only: :dev},
      {:httpoison, "~> 0.11.1"},
      {:poison, "~> 3.0.0"}
    ]
  end
end
