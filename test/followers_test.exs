defmodule Tentacat.FollowersTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Users.Followers

  doctest Tentacat.Users.Followers

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start
  end

  test "following/1" do
    use_cassette "followers#following/1" do
      assert elem(following(@client),1) == []
    end
  end

  test "following/2" do
    use_cassette "followers#following/2" do
      assert elem(following("duksis", @client),1) == []
    end
  end

  test "followers/1" do
    use_cassette "followers#followers/1" do
      {_,[%{"login" => username}],_} = followers(@client)
      assert username == "duksis"
    end
  end

  test "followers/2" do
    use_cassette "followers#followers/2" do
      assert elem(followers("duksis", @client),1) == []
    end
  end

  test "following?/2" do
    use_cassette "followers#following_/2" do
      assert elem(following?("duksis", @client),1) == true
    end
  end

  test "following?/3" do
    use_cassette "followers#following_/3" do
      assert elem(following?("torvalds", "duksis", @client),1) == false
    end
  end

  test "follow/2" do
    use_cassette "followers#follow" do
      assert elem(follow("duksis", @client),1) == true
    end
  end

  test "unfollow/2" do
    use_cassette "followers#unfollow" do
      assert elem(unfollow("duksis", @client),1) == true
    end
  end

end
