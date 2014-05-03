defmodule Tentacat.Mixfile do
  use Mix.Project

  def project do
    [ app: :tentacat,
      version: "0.0.1",
      elixir: "~> 0.13.1",
      deps: deps ]
  end

  def application do
    [ applications: [ :httpoison, :jsex ] ]
  end

  defp deps do
   [ { :httpoison, github: "edgurgel/httpoison", tag: "0.1.0" },
     { :jsex, github: "talentdeficit/jsex" },
     { :meck, github: "eproxus/meck", ref: "69f02255a8219185bf55da303981d86886b3c24b", only: :test } ]
  end
end
