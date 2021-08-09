# Tentacat

[![Build Status](https://travis-ci.org/edgurgel/tentacat.svg)](https://travis-ci.org/edgurgel/tentacat)
[![Coverage Status](http://img.shields.io/coveralls/edgurgel/tentacat.svg)](https://coveralls.io/r/edgurgel/tentacat)
[![Inline docs](http://inch-ci.org/github/edgurgel/tentacat.svg)](http://inch-ci.org/github/edgurgel/tentacat)
[![Module Version](https://img.shields.io/hexpm/v/tentacat.svg)](https://hex.pm/packages/tentacat)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/tentacat/)
[![Total Download](https://img.shields.io/hexpm/dt/tentacat.svg)](https://hex.pm/packages/tentacat)
[![License](https://img.shields.io/hexpm/l/tentacat.svg)](https://github.com/edgurgel/tentacat/blob/master/LICENSE)
[![Last Updated](https://img.shields.io/github/last-commit/edgurgel/tentacat.svg)](https://github.com/edgurgel/tentacat/commits/master)

Simple Elixir wrapper for the [GitHub API](http://developer.github.com/).

Tentacool + Cat = Tentacat

## Features

* Gitignore
* Contents
* Trees
* Projects
* Issues
  * Comments
  * Events
  * Labels
* Pulls
  * Comments
  * Commits
  * Files
  * Reviews
  * Review Requests
* Organizations
  * Members
  * Teams
  * Webhooks
  * Projects
* Teams
  * Members
* Users
  * Emails
  * Keys
  * Projects
* Repositories
  * Webhooks
  * Branches
  * Statuses
  * Deployments
  * Collaborators
  * Contributors
  * Projects

Documentation can be found [here](https://hexdocs.pm/tentacat)

## Quickstart

First, add Tentacat to your `mix.exs` dependencies:

```elixir
def deps do
  [
    {:tentacat, "~> 2.0"}
  ]
end
```

Fetching dependencies and running on elixir console:

```console
mix deps.get
iex -S mix
```

You will something like this:

```elixir
Erlang/OTP 17 [erts-6.0] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false]

Interactive Elixir (0.13.3) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)>
```

Now you can run the examples!

## Examples

Every call to GitHub needs a client, but if you want to use unauthenticated requests we will provide an unauthenticated client for you. Keep in mind that GitHub has different [rate-limits](https://developer.github.com/v3/#rate-limiting) if you authenticate or not.

Getting info from a user using a client:

```elixir
iex> client = Tentacat.Client.new
%Tentacat.Client{auth: nil, endpoint: "https://api.github.com/"}
iex> Tentacat.Users.find client, "edgurgel"
{200,
 %{"avatar_url" => "https://avatars0.githubusercontent.com/u/30873?v=4",
   "bio" => "INSUFFICIENT DATA FOR MEANINGFUL ANSWER",
   "blog" => "http://gurgel.me", "company" => nil,
   "created_at" => "2008-10-24T17:05:04Z", "email" => nil,
   "events_url" => "https://api.github.com/users/edgurgel/events{/privacy}",
   "followers" => 220,
   "followers_url" => "https://api.github.com/users/edgurgel/followers",
   "following" => 75,
   "following_url" => "https://api.github.com/users/edgurgel/following{/other_user}",
   "gists_url" => "https://api.github.com/users/edgurgel/gists{/gist_id}",
   "gravatar_id" => "", "hireable" => nil,
   "html_url" => "https://github.com/edgurgel", "id" => 30873,
   "location" => "Wellington, New Zealand", "login" => "edgurgel",
   "name" => "Eduardo Gurgel",
   "organizations_url" => "https://api.github.com/users/edgurgel/orgs",
   "public_gists" => 13, "public_repos" => 59,
   "received_events_url" => "https://api.github.com/users/edgurgel/received_events",
   "repos_url" => "https://api.github.com/users/edgurgel/repos",
   "site_admin" => false,
   "starred_url" => "https://api.github.com/users/edgurgel/starred{/owner}{/repo}",
   "subscriptions_url" => "https://api.github.com/users/edgurgel/subscriptions",
   "type" => "User", "updated_at" => "2018-02-05T23:24:42Z",
   "url" => "https://api.github.com/users/edgurgel"},
 %HTTPoison.Response{body: %{"avatar_url" => "https://avatars0.githubusercontent.com/u/30873?v=4",
    "bio" => "INSUFFICIENT DATA FOR MEANINGFUL ANSWER",
    "blog" => "http://gurgel.me", "company" => nil,
    "created_at" => "2008-10-24T17:05:04Z", "email" => nil,
    "events_url" => "https://api.github.com/users/edgurgel/events{/privacy}",
    "followers" => 220,
    "followers_url" => "https://api.github.com/users/edgurgel/followers",
    "following" => 75,
    "following_url" => "https://api.github.com/users/edgurgel/following{/other_user}",
    "gists_url" => "https://api.github.com/users/edgurgel/gists{/gist_id}",
    "gravatar_id" => "", "hireable" => nil,
    "html_url" => "https://github.com/edgurgel", "id" => 30873,
    "location" => "Wellington, New Zealand", "login" => "edgurgel",
    "name" => "Eduardo Gurgel",
    "organizations_url" => "https://api.github.com/users/edgurgel/orgs",
    "public_gists" => 13, "public_repos" => 59,
    "received_events_url" => "https://api.github.com/users/edgurgel/received_events",
    "repos_url" => "https://api.github.com/users/edgurgel/repos",
    "site_admin" => false,
    "starred_url" => "https://api.github.com/users/edgurgel/starred{/owner}{/repo}",
    "subscriptions_url" => "https://api.github.com/users/edgurgel/subscriptions",
    "type" => "User", "updated_at" => "2018-02-05T23:24:42Z",
    "url" => "https://api.github.com/users/edgurgel"},
  headers: [{"Date", "Mon, 05 Feb 2018 23:25:36 GMT"},
   {"Content-Type", "application/json; charset=utf-8"},
   {"Content-Length", "1187"}, {"Server", "GitHub.com"}, {"Status", "200 OK"},
   {"X-RateLimit-Limit", "60"}, {"X-RateLimit-Remaining", "59"},
   {"X-RateLimit-Reset", "1517876736"},
   {"Cache-Control", "public, max-age=60, s-maxage=60"}, {"Vary", "Accept"},
   {"ETag", "\"ec2653a252e614a96afacfaeb88d0c39\""},
   {"Last-Modified", "Mon, 05 Feb 2018 23:24:42 GMT"},
   {"X-GitHub-Media-Type", "github.v3; format=json"},
   {"Access-Control-Expose-Headers",
    "ETag, Link, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval"},
   {"Access-Control-Allow-Origin", "*"},
   {"Content-Security-Policy", "default-src 'none'"},
   {"Strict-Transport-Security",
    "max-age=31536000; includeSubdomains; preload"},
   {"X-Content-Type-Options", "nosniff"}, {"X-Frame-Options", "deny"},
   {"X-XSS-Protection", "1; mode=block"}, {"X-Runtime-rack", "0.030182"},
   {"Vary", "Accept-Encoding"},
   {"X-GitHub-Request-Id", "054D:2BC4A:82C2C:A4560:5A78E7EF"}],
  request_url: "https://api.github.com/users/edgurgel", status_code: 200}}
```

Getting info from a user without a defined client:

```elixir
iex> {200, data, _response} = Tentacat.Users.find("edgurgel")

iex> get_in(data, ["name"])
"Eduardo Gurgel"
```

Getting info from the authenticated user:

* Using user and password:

```elixir
iex> client = Tentacat.Client.new(%{user: "user", password: "password"})
%Tentacat.Client{auth: %{user: "user", password: "password"}, endpoint: "https://api.github.com/"}
iex> Tentacat.Users.me(client)
```

* Using a personal access token [Github personal API token](https://github.com/blog/1509-personal-api-tokens):

```elixir
iex> client = Tentacat.Client.new(%{access_token: "928392873982932"})
%Tentacat.Client{auth: %{access_token: "928392873982932"}, endpoint: "https://api.github.com/"}
iex> Tentacat.Users.me(client)
```

Accessing another endpoint:

```elixir
iex> client = Tentacat.Client.new(%{access_token: "928392873982932"}, "https://ghe.example.com/api/v3/")
%Tentacat.Client{auth: %{access_token: "928392873982932"}, endpoint: "https://ghe.example.com/api/v3/"}
iex> Tentacat.Users.me(client)
```

## Misc

Having that Github Reviews API is still in a pre-release state
you need to set an additional header in your config.

```elixir
config :tentacat, :extra_headers, [{"Accept", "application/vnd.github.black-cat-preview+json"}]
```

### Deserialization Options

You can pass deserialization options to the library used to decode JSON
using:

```elixir
# To have Atom keys
config :tentacat, :deserialization_options, [keys: :atoms]
```

See: https://hexdocs.pm/jason/Jason.html#decode/2-options for available options.

## Contributing

Start by forking this repo.

Then run this command to fetch dependencies and run tests:

```console
MIX_ENV=test mix do deps.get, test
```

If you are using Intellij and debugging the test suite - be sure to set `'INTELLIJ_ELIXIR_DEBUG_BLACKLIST=hackney'` in the Elixir Mix Eunit configuration - if you fail to do so the mocked hackney module will be reloaded from disk and tests will behave abnormally.

Pull requests are greatly appreciated.

## Copyright and License

Copyright (c) 2013 Eduardo Gurgel Pinho

Released under the MIT License, which can be found in the repository in
[LICENSE.md](./LICENSE.md) file.
