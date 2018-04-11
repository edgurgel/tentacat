defmodule Tentacat.Repositories.StatusesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Repositories.Statuses

  doctest Tentacat.Repositories.Statuses

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start()
  end

  test "list/4" do
    use_cassette "repositories/statuses#list" do
      assert elem(
               list(
                 @client,
                 "soudqwiggle",
                 "elixir-conspiracy",
                 "bf7c4ab53fe7503b82b9654d5979ebe8c24ea009"
               ),
               1
             ) == []
    end
  end

  test "find/4" do
    use_cassette "repositories/statuses#find" do
      {_, %{"state" => state}, _} =
        find(
          @client,
          "soudqwiggle",
          "elixir-conspiracy",
          "bf7c4ab53fe7503b82b9654d5979ebe8c24ea009"
        )

      assert state == "success"
    end
  end

  test "create/4" do
    body = %{
      state: "success",
      target_url: "https://example.com/build/status",
      description: "The build succeeded!",
      context: "continuous-integration/jenkins"
    }

    use_cassette "repositories/statuses#create" do
      {status_code, _, _} =
        create(
          @client,
          "soudqwiggle",
          "elixir-conspiracy",
          "bf7c4ab53fe7503b82b9654d5979ebe8c24ea009",
          body
        )

      assert status_code == 201
    end
  end
end
