defmodule Tentacat do
  @type auth :: [user: binary, password: binary] | [access_token: binary]
  defrecord Client, [auth: nil] do
    use Tentacat.Users
    use Tentacat.Users.Emails
    use Tentacat.Users.Keys
    use Tentacat.Users.Followers
    use Tentacat.Organizations
    use Tentacat.Gitignore

  end
end
