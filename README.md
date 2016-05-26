[![Build Status](https://travis-ci.org/edgurgel/tentacat.svg)](https://travis-ci.org/edgurgel/tentacat)
[![Coverage Status](http://img.shields.io/coveralls/edgurgel/tentacat.svg)](https://coveralls.io/r/edgurgel/tentacat)
[![Inline docs](http://inch-ci.org/github/edgurgel/tentacat.svg)](http://inch-ci.org/github/edgurgel/tentacat)

# Tentacat

Simple Elixir wrapper for the [GitHub API](http://developer.github.com/).

Tentacool + Cat = Tentacat

## Features

* Gitignore
* Contents
* Trees
* Issues
  * Comments
  * Events
  * Labels
* Pulls
  * Comments
  * Commits
  * Files
* Organizations
  * Members
  * Teams
* Teams
  * Members
* Users
  * Emails
  * Keys
* Repositories
  * Webhooks
  * Branches
  * Statuses
  * Deployments

Documentation can be found [here](https://hexdocs.pm/tentacat)

## Quickstart

First, add Tentacat to your `mix.exs` dependencies:

```elixir
def deps do
  [{:tentacat, "~> 0.5"}]
end
```

Ensure that `tentacat` is added as an application in your `mix.exs`:

```elixir
def application do
  [applications: [:tentacat]]
end
```

Fetching dependencies and running on elixir console:

```console
mix deps.get
iex -S mix
```

You will something like this:

```
Erlang/OTP 17 [erts-6.0] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false]

Interactive Elixir (0.13.3) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)>
```

Now you can run the examples!

## Examples

Every call to GitHub needs a client, but if you want to use unauthenticated requests we will provide an unauthenticated client for you. Keep in mind that GitHub has different [rate-limits](https://developer.github.com/v3/#rate-limiting) if you authenticate or not.

Getting info from a user using a client

```iex
iex> client = Tentacat.Client.new
%Tentacat.Client{auth: nil, endpoint: "https://api.github.com/"}
iex> Tentacat.Users.find "edgurgel", client
[{"login","edgurgel"},{"id",30873},{"avatar_url","https://secure.gravatar.com/avatar/5e0f65b214819fedf529220e19c08908?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"},{"gravatar_id","5e0f65b214819fedf529220e19c08908"},{"url","https://api.github.com/users/edgurgel"},{"html_url","https://github.com/edgurgel"},{"followers_url","https://api.github.com/users/edgurgel/followers"},{"following_url","https://api.github.com/users/edgurgel/following{/other_user}"},{"gists_url","https://api.github.com/users/edgurgel/gists{/gist_id}"},{"starred_url","https://api.github.com/users/edgurgel/starred{/owner}{/repo}"},{"subscriptions_url","https://api.github.com/users/edgurgel/subscriptions"},{"organizations_url","https://api.github.com/users/edgurgel/orgs"},{"repos_url","https://api.github.com/users/edgurgel/repos"},{"events_url","https://api.github.com/users/edgurgel/events{/privacy}"},{"received_events_url","https://api.github.com/users/edgurgel/received_events"},{"type","User"},{"name","Eduardo Gurgel"},{"company","Codeminer 42"},{"blog","http://gurgel.me"},{"location","Fortaleza, Brazil"},{"email","eduardo@gurgel.me"},{"hireable",false},{"bio",nil},{"public_repos",19},{"followers",16},{"following",38},{"created_at","2008-10-24T17:05:04Z"},{"updated_at","2013-06-18T22:52:41Z"},{"public_gists",4}]
```

Getting info from a user without a defined client

```iex
iex> Tentacat.Users.find("edgurgel") |> Dict.get("email")
"eduardo@gurgel.me"
```

Getting info from the authenticated user

* Using user and password:

```iex
iex> client = Tentacat.Client.new(%{user: "user", password: "password"})
%Tentacat.Client{auth: %{user: "user", password: "password"}, endpoint: "https://api.github.com/"}
iex> Tentacat.Users.me(client)
```

* Using a personal access token [Github personal API token](https://github.com/blog/1509-personal-api-tokens)

```iex
iex> client = Tentacat.Client.new(%{access_token: "928392873982932"})
%Tentacat.Client{auth: %{access_token: "928392873982932"}, endpoint: "https://api.github.com/"}
iex> Tentacat.Users.me(client)
```

Accessing another endpoint

```iex
iex> client = Tentacat.Client.new(%{access_token: "928392873982932"}, "https://ghe.example.com/api/v3/")
%Tentacat.Client{auth: %{access_token: "928392873982932"}, endpoint: "https://ghe.example.com/api/v3/"}
iex> Tentacat.Users.me(client)
```

## Contributing

Start by forking this repo

Then run this command to fetch dependencies and run tests:

```console
MIX_ENV=test mix do deps.get, test
```

Pull requests are greatly appreciated
