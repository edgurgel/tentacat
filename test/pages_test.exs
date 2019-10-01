defmodule Tentacat.PagesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Pages

  doctest Tentacat.Pages

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start()
  end

  test "get_info/3" do
    use_cassette "pages#get_info" do
      expected_body = %{
        "cname" => "developer.github.com",
        "custom_404" => false,
        "html_url" => "https://developer.github.com",
        "source" => %{"branch" => "master", "directory" => "/"},
        "status" => "built",
        "url" => "https://api.github.com/repos/github/developer.github.com/pages"
      }

      {200, body, _} = get_info("edgurgel", "ed-pages-site", @client)

      assert body == expected_body
    end
  end


  test "list_builds/3" do
    use_cassette "pages#builds" do
      # [%{"login" => name}] = list_mine(@client)
      {200, body, full} = list_builds("edgurgel", "ed-pages-site", @client)
      assert 1 == "tentatest"
    end
  end

  test "latest/3" do
    use_cassette "pages#latest" do
      {200, body, full} = last_build("edgurgel", "ed-pages-site")
      assert 1 == "dunno"
    end
  end

  # test "find/2" do
  #   use_cassette "organizations#find" do
  #     %{"id" => id} = find("elixir-conspiracy", @client)
  #     assert id == 5861005
  #   end
  # end

  # test "update/3" do
  #   use_cassette "organizations#update" do
  #     %{"location" => location} = update("tentatest", [location: "Vecpiebalga"], @client)
  #     assert location == "Vecpiebalga"
  #   end
  # end
end
