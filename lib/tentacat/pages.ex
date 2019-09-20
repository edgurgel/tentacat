defmodule Tentacat.Pages do
  import Tentacat
  alias Tentacat.Client

  @doc """
  Get pages info for a repository

  ## Example

      Tentacat.Pages.get_info "edgurgel", "ed-pages-site" client

  More info at: https://developer.github.com/v3/repos/pages/#get-information-about-a-pages-site
  """
  @spec get_info(binary, binary, Client.t) :: Tentacat.response
  def get_info(user_or_org,repo, client \\ %Client{}) do
   get "/repos/#{user_or_org}/#{repo}/pages"
  end

  @doc """
  Request a page build

  ## Example

      Tentacat.Pages.request_build user_or_org, repo client

  More info at: https://developer.github.com/v3/repos/pages/#request-a-page-build
  """
  @spec request_build(binary, binary,Client.t) :: Tentacat.response
  def request_build(user_or_org,repo,client) do
    # post "/repos/#{user_or_org}/#{repo}/pages/builds"
  end

  @doc """
  List pages builds

  ## Example

      Tentacat.Pages.list_builds user_or_org, repo client

  More info at: https://developer.github.com/v3/repos/pages/#request-a-page-build
  """
  @spec list_builds(binary, binary,Client.t) :: Tentacat.response
  def list_builds(user_or_org,repo,client) do
    get "/repos/#{user_or_org}/#{repo}/pages/builds"
  end

end
