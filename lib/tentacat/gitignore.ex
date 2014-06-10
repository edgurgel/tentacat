defmodule Tentacat.Gitignore do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List all templates available

  ## Example

      Tentacat.Gitignore.templates
      Tentacat.Gitignore.templates client

  More info at: http:\\developer.github.com/v3/gitignore/#listing-available-templates
  """
  @spec templates(Client.t) :: Tentacat.response
  def templates(client \\ %Client{}) do
    get "gitignore/templates", client.auth
  end

  @doc """
  Get a single template based on the `name`

  ## Example

      Tentacat.Gitignore.template "C"
      Tentacat.Gitignore.template "C", client

  More info at: http:\\developer.github.com/v3/gitignore/#get-a-single-template
  """
  # FIXME We should support raw data type too
  @spec template(binary, Client.t) :: Tentacat.response
  def template(name, client \\ %Client{}) do
    get "gitignore/templates/#{name}", client.auth
  end
end

