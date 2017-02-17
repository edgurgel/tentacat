defmodule Tentacat.NotificationsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Notifications

  doctest Tentacat.Notifications

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start
  end

  test "list/2" do
    use_cassette "notifications#list" do
      assert list(@client) == []
    end
  end

  test "remove/2" do
    use_cassette "notifications#remove" do
      assert remove(@client) == []
    end
  end

end
