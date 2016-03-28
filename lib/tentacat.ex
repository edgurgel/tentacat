defmodule Tentacat do
  use HTTPoison.Base
  alias Tentacat.Client

  @user_agent [{"User-agent", "tentacat"}]

  @type response :: {integer, any} | :jsx.json_term

  @spec process_response_body(binary) :: term
  def process_response_body(""), do: nil
  def process_response_body(body), do: JSX.decode!(body)

  @spec process_response(HTTPoison.Response.t) :: response
  def process_response(%HTTPoison.Response{status_code: 200, body: body}), do: body
  def process_response(%HTTPoison.Response{status_code: status_code, body: body }), do: { status_code, body }

  def delete(path, client, body \\ "") do
    _request(:delete, url(client, path), client.auth, body)
  end

  def post(path, client, body \\ "") do
    _request(:post, url(client, path), client.auth, body)
  end

  def patch(path, client, body \\ "") do
    _request(:patch, url(client, path), client.auth, body)
  end

  def put(path, client, body \\ "") do
    _request(:put, url(client, path), client.auth, body)
  end

  def get(path, client, params \\ []) do
    initial_url = url(client, path)
    url = add_params_to_url(initial_url, params)
    _request(:get, url, client.auth)
  end

  def _request(method, url, auth, body \\ "") do
    json_request(method, url, body, authorization_header(auth, @user_agent))
  end

  def json_request(method, url, body \\ "", headers \\ [], options \\ []) do
    raw_request(method, url, JSX.encode!(body), headers, options)
  end

  def raw_request(method, url, body \\ "", headers \\ [], options \\ []) do
    extra_options = Application.get_env(:tentacat, :request_options, [])
    request!(method, url, body, headers, extra_options ++ options) |> process_response
  end

  @spec url(client :: Client.t, path :: binary) :: binary
  defp url(_client = %Client{endpoint: endpoint}, path) do
    endpoint <> path
  end

  @doc """
  Take an existing URI and add addition params, appending and replacing as necessary

  ## Examples
      iex> add_params_to_url("http://example.com/wat", [])
      "http://example.com/wat"

      iex> add_params_to_url("http://example.com/wat", [q: 1])
      "http://example.com/wat?q=1"

      iex> add_params_to_url("http://example.com/wat", [q: 1, t: 2])
      "http://example.com/wat?q=1&t=2"

      iex> add_params_to_url("http://example.com/wat?q=1&t=2", [])
      "http://example.com/wat?q=1&t=2"

      iex> add_params_to_url("http://example.com/wat?q=1", [t: 2])
      "http://example.com/wat?q=1&t=2"

      iex> add_params_to_url("http://example.com/wat?q=1", [q: 3, t: 2])
      "http://example.com/wat?q=3&t=2"

      iex> add_params_to_url("http://example.com/wat?q=1&s=4", [q: 3, t: 2])
      "http://example.com/wat?q=3&s=4&t=2"
  """
  @spec add_params_to_url(binary, list) :: binary
  def add_params_to_url(url, params) do
    url
    |> URI.parse
    |> merge_uri_params(params)
    |> URI.to_string
  end

  @spec merge_uri_params(URI.t, list) :: URI.t
  defp merge_uri_params(uri, []), do: uri
  defp merge_uri_params(%URI{query: nil} = uri, params) do
    uri
    |> Map.put(:query, URI.encode_query(params))
  end
  defp merge_uri_params(%URI{} = uri, params) do
    uri
    |> Map.update!(:query, fn q -> q |> URI.decode_query |> Map.merge(param_list_to_map_with_string_keys(params)) |> URI.encode_query end)
  end

  @spec param_list_to_map_with_string_keys(list) :: map
  defp param_list_to_map_with_string_keys(list) do
    for {key, value} <- list, into: Map.new do
      {"#{key}", value}
    end
  end

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
