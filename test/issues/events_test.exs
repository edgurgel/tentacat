defmodule Tentacat.Issues.EventsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Issues.Events

  doctest Tentacat.Issues.Events

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start
  end

  test "list/4" do
    use_cassette "issues/events#list" do
      [%{"event" => event}] = list("sdost", "elixir-conspiracy", "1", @client)
      assert event == "closed"
    end
  end

end
