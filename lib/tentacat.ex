defmodule Tentacat do
  defrecord Client, auth: nil do
    record_type auth: [user: binary, password: binary] | [access_token: binary]
  end
end
