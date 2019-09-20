defmodule Tentacat.Organizations.TeamsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Organizations.Teams

  doctest Tentacat.Organizations.Teams

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start()
  end

  test "list/2" do
    use_cassette "organizations/teams#list" do
      assert elem(list(@client, "my_org"), 1) == []
    end
  end

  test "find/2" do
    use_cassette "organizations/teams#find" do
      {_, %{"name" => name}, _} = find(1_500_000)
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
          "my_org/secret_repo2"
        ],
        "privacy" => "closed"
      }

      {status_code, _, _} = create(@client, "my_org", body)
      assert status_code == 201
    end
  end

  test "update/3" do
    use_cassette "organizations/teams#update" do
      {_, %{"name" => name}, _} = update(@client, 2_019_723, %{name: "Updated Name"})
      assert name == "Updated Name"
    end
  end

  test "delete/2" do
    use_cassette "organizations/teams#delete" do
      {status_code, _, _} = delete(@client, 2_019_723)
      assert status_code == 204
    end
  end
end
