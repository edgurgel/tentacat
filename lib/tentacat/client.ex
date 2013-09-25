defmodule Tentacat.Client.Base do
  use HTTPoison.Base

  @user_agent [{"User-agent", "tentacat"}]

  @type response :: {integer, any} | :jsx.json_term

  def process_url(url) do
    "https://api.github.com/" <> url
  end

  @spec process_response(HTTPoison.Response.t) :: response
  def process_response(response) do
    status_code = response.status_code
    headers = response.headers
    body = response.body
    response = unless body == "", do: body |> JSEX.decode!,
    else: nil
    if status_code == 200 do
      response
    else
      {status_code, response}
    end
  end

  def delete(url, auth // nil, body // "") do
    _request(:delete, url, auth, body)
  end

  def post(url, auth // nil, body // "") do
    _request(:post, url, auth, body)
  end

  def patch(url, auth // nil, body // "") do
    _request(:patch, url, auth, body)
  end

  def get(url, auth // nil, params // []) do
    url = <<url :: binary, build_qs(params) :: binary>>
    _request(:get, url, auth)
  end

  def _request(method, url, auth, body // "") do
    request(method, url, body, authorization_header(auth, @user_agent))
  end

  def request(method, url, body // "", headers // [], options // []) do
    super(method, url, JSEX.encode!(body), headers, options) |> process_response
  end

  @spec build_qs([{atom, binary}]) :: binary
  defp build_qs([]), do: ""
  defp build_qs(kvs) do
    kvs = Enum.map(kvs, fn
      {k, v} -> atom_to_list(k) ++ '=' ++ :hackney_url.urlencode(v)
      _ -> throw(:badarg)
    end)
    to_string('?' ++ kvs)
  end

  @doc """
  There are two ways to authenticate through GitHub API v3:

    * Basic authentication
    * OAuth2 Token

  This function accepts both.

  ## Examples

      iex> Tentacat.Client.Base.authorization_header([user: "user", password: "password"], [])
      [{"Authorization", "Basic dXNlcjpwYXNzd29yZA=="}]

      iex> Tentacat.Client.Base.authorization_header([access_token: "92873971893"], [])
      [{"Authorization", "token 92873971893"}]

  ## More info
  http://developer.github.com/v3/#authentication
  """
  @spec authorization_header(Tentacat.auth, list) :: list
  def authorization_header([user: user, password: password], headers) do
    userpass = "#{user}:#{password}"
    headers ++ [{"Authorization", "Basic #{:base64.encode(userpass)}"}]
  end

  def authorization_header([access_token: token], headers) do
    headers ++ [{"Authorization", "token #{token}"}]
  end

  def authorization_header(_, headers), do: headers

end
