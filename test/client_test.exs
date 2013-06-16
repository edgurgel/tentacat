Code.require_file "test_helper.exs", __DIR__

defmodule ClientTest do
  use ExUnit.Case
  import Octokit.Client

  test "authorization_header using user and password" do
    assert authorization_header([user: "user", password: "password"], []) == [Authorization: "Basic dXNlcjpwYXNzd29yZA=="]
  end

  test "authorization_header using access token" do
    assert authorization_header([access_token: "9820103"], []) == [Authorization: "token 9820103"]
  end
end
