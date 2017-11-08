defmodule Tentacat.App do
  import Tentacat
  alias Tentacat.Client

  @doc """
  Get info for the authorized app

  ## Example

      Tentacat.App.me client

  More info at: https://developer.github.com/v3/apps/#get-the-authenticated-github-app
  """
  @spec me(Client.t) :: Tentacat.response
  def me(client) do
    get "app", client
  end

end
