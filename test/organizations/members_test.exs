defmodule Tentacat.Organizations.MembersTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Organizations.Members

  doctest Tentacat.Organizations.Members

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start
  end

  test "list/2" do
    use_cassette "members#list" do
      {_,[%{"login" => login}],_} = list("elixir-conspiracy", @client)
      assert login == "josephwilk"
    end
  end

  test "member?/3" do
    use_cassette "members#member_" do
      {status_code, _,_} = member?("elixir-conspiracy", "josephwilk", @client)
      assert status_code == 404
    end
  end

  test "remove/3" do
    use_cassette "members#remove" do
      {status_code, _,_} = remove("tentatest", "duksis", @client)
      assert status_code == 204
    end
  end

  test "public_list/2" do
    use_cassette "members#public_list" do
      assert elem(public_list("tentatest", @client),1) == []
    end
  end

  test "public_member?/3" do
    use_cassette "members#public_member_" do
      {status_code, _,_} = public_member?("tentatest", "soudqwiggle", @client)
      assert status_code == 404
    end
  end

  test "publicize/3" do
    use_cassette "members#publicize" do
      {status_code, _,_} = publicize("tentatest", "soudqwiggle", @client)
      assert status_code == 204
    end
  end

  test "conceal/3" do
    use_cassette "members#conceal" do
      {status_code, _,_} = conceal("tentatest", "soudqwiggle", @client)
      assert status_code == 204
    end
  end
end
