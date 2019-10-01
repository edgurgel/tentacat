defmodule Tentacat.Pages do

  alias Tentacat.Client
  import Tentacat
  @doc """
  Get pages info for a repository

  ## Example

      Tentacat.Pages.info "edgurgel", "ed-pages-site", client

  More info at: https://developer.github.com/v3/repos/pages/#get-information-about-a-pages-site
  """
  @spec pages(binary, binary, Client.t()) :: Tentacat.response()
  def pages(user_or_org, repo, client \\ %Client{}) do
    get("repos/#{user_or_org}/#{repo}/pages", client)
  end

  @doc """
  Latest pages build

  ## Example

      Tentacat.Pages.last_build user_or_org, repo, client

  More info at: https://developer.github.com/v3/repos/pages/#last
  """
  @spec latest(binary, binary, Client.t()) :: Tentacat.response()
  def latest(user_or_org, repo, client) do
    get("repos/#{user_or_org}/#{repo}/pages/builds/latest", client)
  end

  @doc """
  List pages builds

  ## Example

      Tentacat.Pages.builds user_or_org, repo, client

  More info at: https://developer.github.com/v3/repos/pages/#request-a-page-build
  """
  @spec builds(binary, binary, Client.t()) :: Tentacat.response()
  def builds(user_or_org, repo, client) do
    get("repos/#{user_or_org}/#{repo}/pages/builds", client)
  end

  @doc """
  Request a page build

  ## Example

      Tentacat.Pages.request_build user_or_org, repo, client

  More info at: https://developer.github.com/v3/repos/pages/#request-a-page-build
  """
  @spec request_build(binary, binary, Client.t()) :: Tentacat.response()
  def request_build(user_or_org, repo, client) do
    raw_request(:post,"repos/#{user_or_org}/#{repo}/pages/builds", client, "", %{
      "Accept" =>  "application/vnd.github.mister-fantastic-preview+json"
    },[])
  end
end
