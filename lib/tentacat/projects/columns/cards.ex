defmodule Tentacat.Projects.Columns.Cards do
  import Tentacat, [:except, :delete, 2]
  alias Tentacat.Client

  @doc """
  List project cards

  ## Example

      Tentacat.Projects.Columns.Cards.list 1234
      Tentacat.Projects.Columns.Cards.list client, 1234

  More info at: https://developer.github.com/v3/projects/cards/#list-project-cards
  """
  @spec list(Client.t(), binary) :: Tentacat.response()
  def list(client \\ %Client{}, column_id) do
    get("projects/columns/#{column_id}/cards", client)
  end
end
