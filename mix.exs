defmodule Tentacat.Mixfile do
  use Mix.Project

  @description """
    Simple Elixir wrapper for the GitHub API
  """

  def project do
    [ app: :tentacat,
      version: "0.3.0",
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
   [ { :httpoison, "~> 0.8" },
     { :exjsx, "~> 3.2" },
     {:earmark, "~> 0.1.17", only: :docs},
     {:ex_doc, "~> 0.8.0", only: :docs},
     {:inch_ex, only: :docs},
     {:excoveralls, "~> 0.4", only: :test},
     {:exvcr, "~> 0.6", only: :test},
     { :meck, "~> 0.8", only: :test } ]
  end

  defp package do
    [ maintainers: ["Eduardo Gurgel Pinho", "Jamie Winsor", "Hugo Duksis"],
      licenses: ["MIT"],
      links: %{ "Github" => "https://github.com/edgurgel/tentacat" } ]
  end
end
