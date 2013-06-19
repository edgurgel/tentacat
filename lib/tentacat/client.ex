defmodule Tentacat.Client do
  use HTTPotion.Base

  @user_agent [ "User-agent": "tentacat"]

  def process_url(url) do
    :string.concat 'https://api.github.com/', url
  end

  def process_response(_status_code, _headers, body) do
    body |> to_binary |> JSEX.decode!
  end

  def patch(url, auth // nil, body // "", headers // @user_agent, options // []) do
    _request(:patch, url, auth, body, headers, options)
  end

  def get(url, auth // nil, params // [], headers // @user_agent, options // []) do
    url = <<url :: binary, build_qs(params) :: binary>>
    _request(:get, url, auth, "", headers, options)
  end

  def _request(method, url, auth, body // "", headers // [], options // []) do
    request(method, url, body, authorization_header(auth, headers), options)
  end

  def request(method, url, body // "", headers // [], options // []) do
    super(method, url, JSEX.encode!(body), headers, options)
  end

  @spec build_qs([{atom, binary}]) :: char_list
  defp build_qs([]), do: ""
  defp build_qs(kvs) do
    kvs = Enum.map(kvs, fn
      {k, v} -> atom_to_list(k) ++ '=' ++ :ibrowse_lib.url_encode(to_char_list(v))
      _ -> throw(:badarg)
    end)
    list_to_binary('?' ++ kvs)
  end

  @type auth :: [user: binary, password: binary] | [access_token: binary]
  @doc """
  There are two ways to authenticate through GitHub API v3:

    * Basic authentication
    * OAuth2 Token

  This function accepts both.

  ## Examples

      iex> Tentacat.Client.authorization_header([user: "user", password: "password"], [])
      [Authorization: "Basic dXNlcjpwYXNzd29yZA=="]

      iex> Tentacat.Client.authorization_header([access_token: "92873971893"], [])
      [Authorization: "token 92873971893"]

  ## More info
  http://developer.github.com/v3/#authentication
  """
  @spec authorization_header(auth, list) :: list
  def authorization_header(auth, headers) do
    case auth do
      [user: user, password: password] ->
        userpass = "#{user}:#{password}"
        headers ++ [Authorization: "Basic #{:ibrowse_lib.encode_base64(userpass)}"]
      [access_token: token] ->
        headers ++ [Authorization: "token #{token}"]
      _ -> headers
    end
  end

end
