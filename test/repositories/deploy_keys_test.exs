defmodule Tentacat.Repositories.DeployKeysTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Repositories.DeployKeys

  doctest Tentacat.Repositories.DeployKeys

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start()
  end

  test "list/3" do
    use_cassette "repositories/deploy_keys#list" do
      assert elem(list(@client, "milica-nerlovic", "tentacat"), 1) == []
    end
  end

  test "find/4" do
    use_cassette "repositories/deploy_keys#find" do
      {status_code, _, _} = find(@client, "milica-nerlovic", "tentacat", "1234")
      assert status_code == 404
    end
  end
end
