defmodule Tentacat do
  use HTTPoison.Base

  defmodule Client do
    defstruct auth: nil

    @type auth :: %{user: binary, password: binary} | %{access_token: binary}
    @type t :: %__MODULE__{auth: auth}
  end

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

    if (status_code == 200), do: response,
    else: {status_code, response}
  end

  def delete(url, auth \\ nil, body \\ "") do
    _request(:delete, url, auth, body)
  end

  def post(url, auth \\ nil, body \\ "") do
    _request(:post, url, auth, body)
  end

  def patch(url, auth \\ nil, body \\ "") do
    _request(:patch, url, auth, body)
  end

  def get(url, auth \\ nil, params \\ []) do
    url = <<url :: binary, build_qs(params) :: binary>>
    _request(:get, url, auth)
  end

  def _request(method, url, auth, body \\ "") do
    json_request(method, url, body, authorization_header(auth, @user_agent))
  end

  def json_request(method, url, body \\ "", headers \\ [], options \\ []) do
    request(method, url, JSEX.encode!(body), headers, options) |> process_response
  end

  def raw_request(method, url, body \\ "", headers \\ [], options \\ []) do
    request(method, url, body, headers, options) |> process_response
  end

  @spec build_qs([{atom, binary}]) :: binary
  defp build_qs([]), do: ""
  defp build_qs(kvs), do: to_string('?' ++ URI.encode_query(kvs))

  @doc """
  There are two ways to authenticate through GitHub API v3:

    * Basic authentication
    * OAuth2 Token

  This function accepts both.

  ## Examples

      iex> Tentacat.authorization_header(%{user: "user", password: "password"}, [])
      [{"Authorization", "Basic dXNlcjpwYXNzd29yZA=="}]

      iex> Tentacat.authorization_header(%{access_token: "92873971893"}, [])
      [{"Authorization", "token 92873971893"}]

  ## More info
  http:\\developer.github.com/v3/#authentication
  """
  @spec authorization_header(Client.auth, list) :: list
  def authorization_header(%{user: user, password: password}, headers) do
    userpass = "#{user}:#{password}"
    headers ++ [{"Authorization", "Basic #{:base64.encode(userpass)}"}]
  end

  def authorization_header(%{access_token: token}, headers) do
    headers ++ [{"Authorization", "token #{token}"}]
  end

  def authorization_header(_, headers), do: headers

  @doc """
  Same as `authorization_header/2` but defaults initial headers to include `@user_agent`.
  """
  def authorization_header(options), do: authorization_header(options, @user_agent)
end
