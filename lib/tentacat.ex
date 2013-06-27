defmodule Tentacat do
  defrecord Client, [auth: nil :: [user: binary, password: binary] | [access_token: binary]] do
    use Tentacat.Users
    use Tentacat.Users.Emails
    use Tentacat.Users.Keys
    use Tentacat.Users.Followers
    use Tentacat.Organizations
    use Tentacat.Gitignore

  end
end
