defmodule Octokit.Mixfile do
  use Mix.Project

  def project do
    [ app: :'octokit.ex',
      version: "0.0.1",
      deps: deps ]
  end

  def application do
    [ applications: [ :httpotion, :jsex ] ]
  end

  defp deps do
   [
    {:httpotion, github: "myfreeweb/httpotion"},
    {:jsex, github: "talentdeficit/jsex"}
   ]
  end
end
