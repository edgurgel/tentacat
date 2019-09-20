defmodule Tentacat.App do
  import Tentacat
  alias Tentacat.Client

  @doc """
  Get info for the authorized app

  ## Example

      Tentacat.App.me client

  More info at: https://developer.github.com/v3/apps/#get-the-authenticated-github-app
  """
  @spec me(Client.t()) :: Tentacat.response()
  def me(client) do
    get("app", client)
  end

  @doc """
  Get info for a single app

  ## Example

      Tentacat.App.find "tentacatty"

  More info at: https://developer.github.com/v3/apps/#get-a-single-github-app
  """
  @spec find(Client.t(), binary) :: Tentacat.response()
  def find(client \\ %Client{}, slug) do
    get("apps/#{slug}", client)
  end
end
