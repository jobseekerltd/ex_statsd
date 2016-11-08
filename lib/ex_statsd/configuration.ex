defmodule ExStatsD.Configuration do
  @moduledoc """
  Configuration for ExStatsD

  The following values are available for use:

  * `host`: The hostname or IP address (default: 127.0.0.1)
  * `port`: The port number (default: 8125)
  * `namespace`: The namespace to prepend to stats (default: nil)
  * `sink`: (default: nil)
  * `worker_count`: The number of workers to use for to process stats (default: 1)
  """

  @defaults %{
    port: 8125,
    host: "127.0.0.1",
    namespace: nil,
    sink: nil,
    worker_count: 1,
  }

  @doc """
  Returns the config value for they given key.

  Will provide a default value if it exists. See module doc for list of keys and defaults.
  """
  def get(key), do: Application.get_env(:ex_statsd, key, Map.get(@defaults, key))

end
