defmodule ReleaseAdmin.TestConfig do
  @behaviour ReleaseAdmin.RuntimeConfig

  #  https://hexdocs.pm/cloak/generate_keys.html
  @spec _db_secret_key() :: String.t()
  def _db_secret_key(), do: "FKdUNuBTekEOfuywme/rJMQLl8Wu/9Ll/1uy2aoZelk=" |> Base.decode64!()
end
