defmodule Tentacat.Organizations.TeamsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Organizations.Teams

  doctest Tentacat.Organizations.Teams

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start
  end

  test "list/2" do
    use_cassette "organizations/teams#list" do
      assert list("my_org", @client) == []
    end
  end

  test "find/2" do
    use_cassette "organizations/teams#find" do
      %{"name" => name} = find(1500000, @client)
      assert name == "Founders"
    end
  end

  test "create/3" do
    use_cassette "organizations/teams#create" do
      body = %{
        "name" => "my new team",
        "description" => "Team for everyone with commit access",
        "repo_names" => [
          "my_org/secret_repo",
          "my_org/secret_repo2",
        ],
        "privacy" => "closed",
      }
      {status_code, _} = create("my_org", body, @client)
      assert status_code == 201
    end
  end

  test "update/3" do
    use_cassette "organizations/teams#update" do
      %{"name" => name} = update(2019723, %{name: "Updated Name"}, @client)
      assert name == "Updated Name"
    end
  end

  test "delete/2" do
    use_cassette "organizations/teams#delete" do
      {status_code, _} = delete(2019723, @client)
      assert status_code == 204
    end
  end
end
