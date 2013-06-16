defmodule Octokit.Client do
  use HTTPotion.Base

  @user_agent [ "User-agent": "octokit.ex"]

  def process_url(url) do
    :string.concat 'https://api.github.com/', url
  end

  def process_response(_status_code, _headers, body) do
    body |> to_binary |> JSEX.decode!
  end

  def get(url, auth // nil, headers // @user_agent, options // []) do
    _request(:get, url, auth, "", headers, options)
  end

  def _request(method, url, nil, body // "", headers // [], options // []) do
    request(method, url, body, headers, options)
  end
  def _request(method, url, auth, body // "", headers // [], options // []) do
    headers = authorization_header(auth, headers)
    request(method, url, body, headers, options)
  end

  @doc """
  There are two ways to authenticate through GitHub API v3:

    * Basic authentication
    * OAuth2 Token

  This function accepts both.

  ## Examples

      iex> Octokit.Client.authorization_header([user: "user", password: "password"], [])
      [Authorization: "Basic dXNlcjpwYXNzd29yZA=="]

      iex> Octokit.Client.authorization_header([access_token: "92873971893"], [])
      [Authorization: "token 92873971893"]

  ## More info
  http://developer.github.com/v3/#authentication
  """
  @spec authorization_header([user: binary, password: binary] | [access_token: binary], list) :: list
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
