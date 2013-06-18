[![Build Status](https://travis-ci.org/edgurgel/tentacat.png)](https://travis-ci.org/edgurgel/tentacat)

# Tentacat

Simple Elixir wrapper for the GitHub API.

Tentacool + Cat = Tentacat

Elixir 0.9.2 required

## Examples

Getting info from an user

```iex
iex>  Tentacat.Users.user("edgurgel")
[{"login","edgurgel"},{"id",30873},{"avatar_url","https://secure.gravatar.com/avatar/5e0f65b214819fedf529220e19c08908?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"},{"gravatar_id","5e0f65b214819fedf529220e19c08908"},{"url","https://api.github.com/users/edgurgel"},{"html_url","https://github.com/edgurgel"},{"followers_url","https://api.github.com/users/edgurgel/followers"},{"following_url","https://api.github.com/users/edgurgel/following{/other_user}"},{"gists_url","https://api.github.com/users/edgurgel/gists{/gist_id}"},{"starred_url","https://api.github.com/users/edgurgel/starred{/owner}{/repo}"},{"subscriptions_url","https://api.github.com/users/edgurgel/subscriptions"},{"organizations_url","https://api.github.com/users/edgurgel/orgs"},{"repos_url","https://api.github.com/users/edgurgel/repos"},{"events_url","https://api.github.com/users/edgurgel/events{/privacy}"},{"received_events_url","https://api.github.com/users/edgurgel/received_events"},{"type","User"},{"name","Eduardo Gurgel"},{"company","Codeminer 42"},{"blog","http://gurgel.me"},{"location","Fortaleza, Brazil"},{"email",nil},{"hireable",false},{"bio",nil},{"public_repos",19},{"followers",15},{"following",37},{"created_at","2008-10-24T17:05:04Z"},{"updated_at","2013-06-16T11:30:45Z"},{"public_gists",2}]
```

Getting info from the authenticated user

* Using user and password:

```iex
iex>  Tentacat.Users.me([user: "myuser", password: "mypassword"])
```

* Using a personal access token [Github personal API token](https://github.com/blog/1509-personal-api-tokens)

```iex
iex> Tentacat.Users.me([access_token: "4f8275892d61d2f6c9cfc64cdd32cfdaef0ac7"])
```
