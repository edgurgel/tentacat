defmodule Tentacat.Mixfile do
  use Mix.Project

  @source_url "https://github.com/edgurgel/tentacat"
  @version "2.2.0"

  def project do
    [
      app: :tentacat,
      version: @version,
      elixir: "~> 1.9",
      name: "Tentacat",
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.detail": :test, "coveralls.post": :test],
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:jason, "~> 1.2"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:inch_ex, "~> 0.5", only: :dev},
      {:excoveralls, "~> 0.5", only: :test},
      {:exvcr, "~> 0.10.3", only: :test},
      {:meck, "~> 0.8.9", only: :test}
    ]
  end

  defp package do
    [
      description: "Simple Elixir wrapper for the GitHub API",
      maintainers: ["Eduardo Gurgel Pinho", "Jamie Winsor", "Hugo Duksis"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      extras: [
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Overview"],
        "guides/getting_started.md": [title: "Getting Started"]
      ],
      main: "readme",
      source_url: @source_url,
      formatters: ["html"]
    ]
  end
end
