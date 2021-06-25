# Getting Started

In this guide we will walk step-by-step through the installation and basic usage of the Tentacat library.


## Installation

Add Tentacat to your project's `mix.exs` dependencies:

```elixir
def deps do
  [
    {:tentacat, "~> 1.0"}
  ]
end
```

**Note for users of Elixir <1.3**: Ensure that `tentacat` is added as an application in `mix.exs`:

```elixir
def application do
  [
    applications: [:tentacat]
  ]
end
```

Finally, fetch dependencies for your project:

```
$ mix deps.get
```

## Configuration

Tentacat accepts a number of configuration options using the application environment:

```elixir
config :tentacat,
  deserialization_options: [],
  extra_headers: [],
  pagination: [],
  request_options: []
```

* `:deserialization_options`: List of options to be passed through `Jason.decode!/2`. See [the Jason documentation](https://hexdocs.pm/jason/Jason.html#decode/2-options) for more information.
* `:extra_headers`: List of two-element tuples defining additional HTTP headers for `HTTPoison.request/5`. For alternative ways of specifying headers, see `t:HTTPoison.Base.headers/0`.
* `:pagination`: Specifies the default method of pagination (can also be set on a per-request basis). See `Tentacat.get/4` for more information.
* `:request_options`: Keyword list of options to be passed to `HTTPoison.request/5`.


## Creating the Client

Often, the first step in using Tentacat is to create a `%Tentacat.Client{}` struct. This struct will hold information about the endpoint to use and the method of authentication.

### Using a username and password

This option may not work for users with multi-factor authentication enabled on their GitHub account.

```elixir
client = Tentacat.Client.new(%{user: "user", password: "password"})
```

### Using a personal access token

To generate a GitHub API personal access token, visit your [GitHub settings](https://github.com/settings/tokens) and click **Generate new token**. Give the token a short description and ensure that it has all of the scopes necessary for the API calls you wish to make.

```elixir
client = Tentacat.Client.new(%{access_token: "928392873982932"})
```

### Without authentication

It is also possible to use Tentacat without specifying an authentication method. Please note that this will limit the API actions you are able to take. To do this, call each function without the `client` argument, i.e.

```elixir
Tentacat.Users.find("edgurgel")
```

### Connecting to an alternative endpoint

We may create a client for an endpoint other than the GitHub API:

```elixir
client = Tentacat.Client.new(%{access_token: "928392873982932"}, "https://ghe.example.com/api/v3/")
```


## Calling the GitHub API

With a client struct created (or skipped), we are now ready to call the GitHub API. Following are a few examples:

```elixir
# Get a user's profile information.
Tentacat.Users.find(client, "edgurgel")

# Create a comment on an issue.
Tentacat.Issues.Comments.create("edgurgel", "tentacat", 72, %{"body" => "This is a comment created using the API"})
```

For a full list of actions, see the [API Reference](api-reference.html).


### Things to keep in mind

Note that the documentation for this library often does not give a comprehensive list of parameters that can be passed to the various endpoints. To see what the API will accept, use the [GitHub API Documentation](https://developer.github.com/).

The GitHub API often releases modifications to an endpoint as a preview. In order to use and endpoint in a preview state, additional headers are necessary in the request. See [API Previews](https://developer.github.com/v3/previews/) for information about the media type necessary to use a particular endpoint:

```elixir
config :tentacat,
  extra_headers: [{"Accept", "application/vnd.github.MEDIA-TYPE+json"}]
```
