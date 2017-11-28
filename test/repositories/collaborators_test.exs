defmodule Tentacat.Repositories.CollaboratorsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Repositories.Collaborators

  doctest Tentacat.Repositories.Collaborators

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start
  end

  test "list/3" do
    use_cassette "repositories/collaborators#list" do
      assert elem(list("andersklenke", "tentatest", @client),1) |> Enum.count()  == 1
    end
  end

  test "collaborator?/4" do
    use_cassette "repositories/collaborators#collaborator?" do
      assert {204, _,_} = collaborator?("andersklenke", "tentatest", "andersklenke", @client)
      assert {404, _,_} = collaborator?("andersklenke", "tentatest", "no", @client)
    end
  end

  test "add/4" do
    use_cassette "repositories/collaborators#add" do
      assert {204, _,_} = add("andersklenke", "tentatest", "tentatest123", %{}, @client)
    end
  end

  test "delete/4" do
    use_cassette "repositories/collaborators#delete" do
      assert {204, _,_} = delete("andersklenke", "tentatest", "tentatest123", @client)
    end
  end
end
