Code.require_file "test_helper.exs", __DIR__

defmodule ClientTest do
  use ExUnit.Case
  import Tentacat.Client

  doctest Tentacat.Client

  setup do
    :meck.new JSEX
  end

  teardown do
    :meck.unload JSEX
  end


  test "authorization_header using user and password" do
    assert authorization_header([user: "user", password: "password"], []) == [Authorization: "Basic dXNlcjpwYXNzd29yZA=="]
  end

  test "authorization_header using access token" do
    assert authorization_header([access_token: "9820103"], []) == [Authorization: "token 9820103"]
  end

  test "process response on a 200 response" do
    :meck.expect(JSEX, :decode!, 1, :decoded_json)
    assert process_response('200', [], "json") == :decoded_json
    assert :meck.validate(JSEX)
  end

  test "process response on a non-200 response" do
    :meck.expect(JSEX, :decode!, 1, :decoded_json)
    assert process_response('404', [], "json") == {404, :decoded_json}
    assert :meck.validate(JSEX)
  end
end
