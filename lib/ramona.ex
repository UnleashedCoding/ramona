defmodule Ramona do
  @moduledoc false
  use Application
  alias Alchemy.{Client, Cogs}

  def start(_type, _args) do
    case Application.get_env(:ramona, :token) do
      nil ->
        raise "TOKEN environment variable is not set"

      token ->
        prefix = Application.fetch_env!(:ramona, :prefix)
        bootstrap(token, prefix)
    end
  end

  defp bootstrap(token, prefix) do
    run = Client.start(token)
    load_modules()
    Cogs.set_prefix(prefix)
    run
  end

  defp load_modules do
    use Ramona.Events
    use Ramona.Events.Macros
    use Ramona.Commands.Basic
    use Ramona.Commands.Morse
    use Ramona.Commands.Macros
    use Ramona.Commands.Random
    use Ramona.Commands.Moderation
  end
end
