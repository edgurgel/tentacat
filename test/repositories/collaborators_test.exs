defmodule Tentacat.Repositories.CollaboratorsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Repositories.Collaborators

  doctest Tentacat.Repositories.Collaborators

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start()
  end

  test "list/3" do
    use_cassette "repositories/collaborators#list" do
      assert elem(list(@client, "andersklenke", "tentatest"), 1) |> Enum.count() == 1
    end
  end

  test "collaborator?/4" do
    use_cassette "repositories/collaborators#collaborator" do
      assert {204, _, _} = collaborator?(@client, "andersklenke", "tentatest", "andersklenke")
      assert {404, _, _} = collaborator?(@client, "andersklenke", "tentatest", "no")
    end
  end

  test "permission/4" do
    use_cassette "repositories/collaborators#permission" do
      assert {200, %{"permission" => "admin"}, _} = permission(@client, "bmarkons", "script", "bmarkons")
      assert {200, %{"permission" => "read"}, _}  = permission(@client, "bmarkons", "script", "no")
    end
  end

  test "add/4" do
    use_cassette "repositories/collaborators#add" do
      assert {204, _, _} = add(@client, "andersklenke", "tentatest", "tentatest123", %{})
    end
  end

  test "delete/4" do
    use_cassette "repositories/collaborators#delete" do
      assert {204, _, _} = delete(@client, "andersklenke", "tentatest", "tentatest123")
    end
  end
end
