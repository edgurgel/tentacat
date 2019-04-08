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

  test "create/4" do
    use_cassette "repositories/deploy_keys#create" do
      key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCc72ESoMRGBQJBjnUUSNo1uoRnV7PI82KtqfSLjcmj3fUB0OvVx8haMhtb7hlxKb5J7J2vLNONyRgNryUkOFTwfHpCt0TZqCKMvp9AuYyAQH2E1kbIGPQ/6BTCktGXq200Ua2hM5NNZjuCgxgMNoyxMzoSb5qChCXatQLIzbODBhyMEPwUq3PqAieirCEPIjXRr2jEAR9+xL8UnHb2e3ZcjuqZPB+yiZZSzZA5IDs3zW7RBQB6ZLoIInUWRxR41YE/2gNeUe4FwhXfxXane/4zkiNqqClE2rDo25MocVpqzP8niVuwQYPYsxEGOo/RIaQa55wvD/LMIwEaOVdbnRl7"
      body = %{
        "title" => "test_key",
        "read_only" => true,
        "key" => key
      }

      {status_code, body, _} = create(@client, "milica-nerlovic", "tentacat", body)
      assert status_code == 201
      assert body["read_only"] == true
      assert body["title"] == "test_key"
      assert body["key"] == key
    end
  end

  test "remove/4" do
    use_cassette "repositories/deploy_keys#remove" do
      {status_code, _, _} = remove(@client, "milica-nerlovic", "tentacat", 34_371_109)
      assert status_code == 204
    end
  end
end
