defmodule Tentacat.Gitignore do
  import Tentacat.Client
  @doc """
  List all templates available

  ## Example

      Tentacat.Gitignore.templates

  More info at: http://developer.github.com/v3/gitignore/#listing-available-templates
  """
  @spec templates :: :jsx.json_term
  def templates do
    get "gitignore/templates"
  end

  @doc """
  Get a single template based on the `name`

  ## Example

      Tentacat.Gitignore.template("C")

  More info at: http://developer.github.com/v3/gitignore/#get-a-single-template
  """
  # FIXME We should support raw data type too
  @spec template(binary) :: :jsx.json_term
  def template(name) do
    get "gitignore/templates/#{name}"
  end

end

