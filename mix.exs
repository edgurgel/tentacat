defmodule Tentacat.Mixfile do
  use Mix.Project

  @description """
    Simple Elixir wrapper for the GitHub API
  """

  def project do
    [ app: :tentacat,
      version: "0.1.0",
      elixir: "~> 0.15.0",
      name: "Tentacat",
      description: @description,
      package: package,
      deps: deps ]
  end

  def application do
    [ applications: [ :httpoison, :jsex ] ]
  end

  defp deps do
   [ { :httpoison, "~> 0.4.0" },
     { :jsex, "~> 2.0" },
     { :meck, "~> 0.8.2", only: :test } ]
  end

  defp package do
    [ contributors: ["Eduardo Gurgel Pinho", "Jamie Winsor"],
      licenses: ["MIT"],
      links: [ { "Github", "https://github.com/edgurgel/tentacat" } ] ]
  end
end
