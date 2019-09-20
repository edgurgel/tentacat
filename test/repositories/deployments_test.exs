defmodule Tentacat.Repositories.DeploymentsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Repositories.Deployments

  doctest Tentacat.Repositories.Deployments

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start()
  end

  test "list/3" do
    use_cassette "repositories/deployments#list" do
      assert elem(list(@client, "soudqwiggle", "elixir-conspiracy"), 1) == []
    end
  end

  test "create/4" do
    body = %{
      "ref" => "master",
      "payload" => "{\"user\":\"atmos\",\"room_id\":123456}",
      "description" => "Deploying my sweet branch"
    }

    use_cassette "repositories/deployments#create" do
      {status_code, _, _} = create(@client, "soudqwiggle", "elixir-conspiracy", body)
      assert status_code == 201
    end
  end

  test "list_statuses/4" do
    use_cassette "repositories/deployments#list_statuses" do
      assert elem(list_statuses(@client, "soudqwiggle", "elixir-conspiracy", 2_936_534), 1) == []
    end
  end

  test "create_status/5" do
    body = %{
      state: "success",
      target_url: "https://example.com/deployment/1/output",
      description: "Deployment finished successfully."
    }

    use_cassette "repositories/deployments#create_status" do
      {status_code, _, _} =
        create_status(@client, "soudqwiggle", "elixir-conspiracy", 2_936_534, body)

      assert status_code == 201
    end
  end
end
