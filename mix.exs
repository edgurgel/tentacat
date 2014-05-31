defmodule Tentacat.Mixfile do
  use Mix.Project

  def project do
    [ app: :tentacat,
      version: "0.0.1",
      elixir: "~> 0.13.3",
      deps: deps ]
  end

  def application do
    [ applications: [ :httpoison, :jsex ] ]
  end

  defp deps do
   [ { :httpoison, github: "edgurgel/httpoison", tag: "0.1.1" },
     { :jsex, "~> 2.0" },
     { :meck, github: "eproxus/meck", tag: "0.8.2", only: :test } ]
  end
end
