defmodule Tentacat.Mixfile do
  use Mix.Project

  @description """
    Simple Elixir wrapper for the GitHub API
  """

  def project do
    [
      app: :tentacat,
      version: "1.1.0",
      elixir: "~> 1.7",
      name: "Tentacat",
      description: @description,
      package: package(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.detail": :test, "coveralls.post": :test],
      deps: deps()
    ]
  end

  def application do
    [applications: [:httpoison, :exjsx]]
  end

  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:ex_doc, "~> 0.19", only: :dev},
      {:inch_ex, "~> 1.0", only: :dev},
      {:excoveralls, "~> 0.10", only: :test},
      {:exvcr, "~> 0.10.2", only: :test},
      {:meck, "~> 0.8.9", only: :test}
    ]
  end

  defp package do
    [
      maintainers: ["Eduardo Gurgel Pinho", "Jamie Winsor", "Hugo Duksis"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/edgurgel/tentacat"}
    ]
  end
end
