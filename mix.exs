defmodule Tentacat.Mixfile do
  use Mix.Project

  @description """
    Simple Elixir wrapper for the GitHub API
  """

  def project do
    [
      app: :tentacat,
      version: "1.6.0",
      elixir: "~> 1.7",
      name: "Tentacat",
      description: @description,
      package: package(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.detail": :test, "coveralls.post": :test],
      deps: deps(),

      # Docs
      name: "Tentacat",
      source_url: "https://github.com/edgurgel/tentacat",
      docs: [
        main: "readme",
        extras: [
          "README.md",
          "guides/Getting Started.md"
        ]
      ]
    ]
  end

  def application do
    [applications: [:httpoison, :exjsx]]
  end

  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:exjsx, "~> 4.0"},
      {:earmark, "~> 1.2", only: :dev},
      {:ex_doc, "~> 0.19", only: :dev},
      {:inch_ex, "~> 0.5", only: :dev},
      {:excoveralls, "~> 0.5", only: :test},
      {:exvcr, "~> 0.10.3", only: :test},
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
