defmodule Tentacat.Gitignore do
  import Tentacat
  alias Tentacat.Client

  @doc """
  List all templates available.

  ## Example

      Tentacat.Gitignore.templates
      Tentacat.Gitignore.templates client

  More info at: http:\\developer.github.com/v3/gitignore/#listing-available-templates
  """
  @spec templates(Client.t()) :: Tentacat.response()
  def templates(client \\ %Client{}) do
    get("gitignore/templates", client)
  end

  @doc """
  Get a single template based on the `name`.

  ## Example

      Tentacat.Gitignore.template "C"
      Tentacat.Gitignore.template client, "C"

  More info at: http:\\developer.github.com/v3/gitignore/#get-a-single-template
  """
  # FIXME We should support raw data type too
  @spec template(Client.t(), binary) :: Tentacat.response()
  def template(client \\ %Client{}, name) do
    get("gitignore/templates/#{name}", client)
  end
end
