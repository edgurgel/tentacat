defmodule Octokit.Client do
  use HTTPotion.Base

  @user_agent [ "User-agent": "octokit.ex"]

  def process_url(url) do
    :string.concat 'https://api.github.com/', url
  end

  def process_response(_status_code, _headers, body) do
    body |> to_binary |> JSEX.decode!
  end

  def get(url, headers // @user_agent, options // []), do: request(:get, url, "", headers, options)

end
