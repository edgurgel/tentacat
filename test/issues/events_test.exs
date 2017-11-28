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
      {_,[%{"event" => event}],_} = list("sdost", "elixir-conspiracy", "1", @client)
      assert event == "closed"
    end
  end

  test "list_all/3" do
    use_cassette "issues/events#list_all" do
      assert elem(list_all("sdost", "elixir-conspiracy", @client),1) |> Enum.count()  == 7
    end
  end

  test "find/4" do
    use_cassette "issues/events#find" do
      {_,%{"event" => event},_} = find("sdost", "elixir-conspiracy", 607575270, @client)
      assert event == "closed"
    end
  end

end
