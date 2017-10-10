defmodule Tentacat.Repositories.Contributors do
    import Tentacat
    alias Tentacat.Client
  
    @doc """
    List contributors for a specific repository
  
    ## Example
        Tentacat.Repositories.contributors.list "elixir-lang", "elixir"
        Tentacat.Repositories.contributors.list "elixir-lang", "elixir", client
  
    More info at: https://developer.github.com/v3/repos/#list-contributors
    """
    @spec list(binary, binary, Client.t) :: Tentacat.response
    def list(owner, repo, client \\ %Client{}) do
      get "repos/#{owner}/#{repo}/contributors", client
    end
  
end