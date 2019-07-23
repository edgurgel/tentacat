defmodule Tentacat.Repositories.ContentsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Repositories.Contents

  doctest Tentacat.Repositories.Contents

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start()
  end

  test "content/4" do
    use_cassette "repositories/contents#content" do
      {_, body, _} = content(@client, "edgurgel", "tentacat", "LICENSE")

      assert String.slice(:base64.mime_decode(body["content"]), 0, 9) == "Copyright"
    end
  end
end
