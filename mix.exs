defmodule Tentacat.Mixfile do
  use Mix.Project

  @description """
    Simple Elixir wrapper for the GitHub API
  """

  def project do
    [ app: :tentacat,
      version: "0.2.1",
      elixir: "~> 1.0",
      name: "Tentacat",
      description: @description,
      package: package,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.post": :test],
      deps: deps ]
  end

  def application do
    [ applications: [ :httpoison, :exjsx ] ]
  end

  defp deps do
   [ { :httpoison, "~> 0.7.3" },
     { :exjsx, "~> 3.0" },
     {:earmark, "~> 0.1.17", only: :docs},
     {:ex_doc, "~> 0.8.0", only: :docs},
     {:excoveralls, "~> 0.4", only: :test},
     { :meck, "~> 0.8.2", only: :test } ]
  end

  defp package do
    [ contributors: ["Eduardo Gurgel Pinho", "Jamie Winsor"],
      licenses: ["MIT"],
      links: %{ "Github" => "https://github.com/edgurgel/tentacat" } ]
  end
end
