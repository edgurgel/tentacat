defmodule Tentacat.ReferencesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.References

  doctest Tentacat.References

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start()
  end

  test "list/3" do
    use_cassette "references#list" do
      assert elem(list(@client, "soudqwiggle", "elixir-conspiracy"), 1) == []
    end
  end

  test "find/4" do
    use_cassette "references#find" do
      {_, %{"ref" => ref}, _} = find(@client, "soudqwiggle", "elixir-conspiracy", "pull/2/merge")
      assert ref == "refs/pull/2/merge"
    end
  end

  test "create/4" do
    use_cassette "references#create" do
      body = %{
        "ref" => "refs/heads/old-readme",
        "sha" => "2ff6f7942773c268dc9ab0e11e9dffad402c1860"
      }

      {status_code, _, _} = create(@client, "soudqwiggle", "elixir-conspiracy", body)
      assert status_code == 201
    end
  end

  test "update/5" do
    body = %{
      "sha" => "bf7c4ab53fe7503b82b9654d5979ebe8c24ea009",
      "force" => true
    }

    use_cassette "references#update" do
      {_, %{"ref" => ref}, _} =
        update(@client, "soudqwiggle", "elixir-conspiracy", "heads/master", body)

      assert ref == "refs/heads/master"
    end
  end

  test "remove/4" do
    use_cassette "references#remove" do
      {status_code, _, _} =
        remove(@client, "soudqwiggle", "elixir-conspiracy", 'heads/old-readme')

      assert status_code == 204
    end
  end
end
