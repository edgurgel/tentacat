defmodule Tentacat.Issues.LabelsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Issues.Labels

  doctest Tentacat.Issues.Labels

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start()
  end

  test "list/4" do
    use_cassette "issues/labels#list" do
      assert elem(list(@client, "sdost", "elixir-conspiracy", "1"), 1) == []
    end
  end

  test "add/5" do
    use_cassette "issues/labels#add" do
      {_, [%{"name" => name}], _} = add(@client, "sdost", "elixir-conspiracy", "1", ["WIP"])
      assert name == "WIP"
    end
  end

  test "remove/5" do
    use_cassette "issues/labels#remove" do
      {status_code, _, _} = remove(@client, "dwyl", "learn-elixir", "1", "WIP")
      assert status_code == 204
    end
  end
end
