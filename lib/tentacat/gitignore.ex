defmodule Tentacat.Gitignore do
  import Tentacat.Client.Base
  alias Tentacat.Client

  @doc """
  List all templates available

  ## Example

      Tentacat.Gitignore.templates
      Tentacat.Gitignore.templates client

  More info at: http://developer.github.com/v3/gitignore/#listing-available-templates
  """
  @spec templates(Client.t) :: :jsx.json_term
  def templates(client // Client.new) do
    get "gitignore/templates", client.auth
  end

  @doc """
  Get a single template based on the `name`

  ## Example

      Tentacat.Gitignore.template "C"
      Tentacat.Gitignore.template "C", client

  More info at: http://developer.github.com/v3/gitignore/#get-a-single-template
  """
  # FIXME We should support raw data type too
  @spec template(binary, Client.t) :: :jsx.json_term
  def template(name, client // Client.new) do
    get "gitignore/templates/#{name}", client.auth
  end
end

