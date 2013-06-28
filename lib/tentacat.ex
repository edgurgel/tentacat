defmodule Tentacat do
  defrecord Client, [auth: nil :: [user: binary, password: binary] | [access_token: binary]]
end
