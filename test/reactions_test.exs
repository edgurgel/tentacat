defmodule Tentacat.ReactionsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Reactions

  doctest Tentacat.Releases

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start()
  end

  # TODO: The current credentials used with ExVCR do not work for this endpoint. Fix later
  @tag :skip
  test "delete/4" do
    use_cassette "reactions#delete" do
      {status_code, _, _} = delete(@client, 2_317_708)
      assert status_code == 204
    end
  end
end
