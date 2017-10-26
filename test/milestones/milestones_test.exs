defmodule Tentacat.MilestonesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Milestones

  doctest Tentacat.Milestones

  @client Tentacat.Client.new(%{access_token: "yourtokenhere"})

  setup_all do
    HTTPoison.start
  end

  test "list/3" do
    use_cassette "milesones/milestones#list" do
      assert list("scrumpointerorg", "application", @client) |> Enum.count() == 1
    end
  end

  test "find/4" do
    use_cassette "milesones/milestones#find" do
      assert %{"number" => 1} = find("scrumpointerorg", "application", "1", @client)
    end
  end

  test "create/4" do
    use_cassette "milesones/milestones#create" do
      body = %{
        "title" => "Amazing new Readme",
        "state" => "open"
      }
      {status_code, _} = create("scrumpointerorg", "application", body, @client)
      assert status_code == 201
    end
  end

  test "update/5" do
    use_cassette "milesones/milestones#update" do
      body = %{
        "state" => "closed"
      }
      assert %{"state" => "closed"} = update("scrumpointerorg", "application", "1", body, @client)
    end
  end

  test "delete/5" do
    use_cassette "milesones/milestones#delete" do
      {status_code, _} =  delete("scrumpointerorg", "application", "1", @client)
      assert status_code == 204
    end
  end
end