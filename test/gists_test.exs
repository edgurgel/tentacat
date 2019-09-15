defmodule Tentacat.GistsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Gists

  doctest Tentacat.Gists

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start()
  end

  test "delete/2" do
    use_cassette "gists#delete" do
      {status, _response, _} = delete(@client, "0feff8bfe771b85ee0c3840afd78d177")
      assert status == 204
    end
  end
end
