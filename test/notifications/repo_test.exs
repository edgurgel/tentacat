defmodule Tentacat.Notifications.RepoTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Notifications.Repo

  doctest Tentacat.Notifications.Repo

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start
  end

  test "list/4" do
    use_cassette "notifications/repo#list" do
      assert list("tentatest", "tentacat", @client) == []
    end
  end

  test "remove/4" do
    use_cassette "notifications/repo#remove" do
      assert remove("tentatest", "tentacat", @client) == {205, nil}
    end
  end

end
