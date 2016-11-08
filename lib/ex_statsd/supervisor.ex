defmodule ExStatsD.Supervisor do
  use Supervisor
  alias ExStatsD.Configuration

  def start_link(_) do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    children = [
      worker(ExStatsD, [], restart: :permanent)
    ]

    # start n workers
    children = (1..Configuration.get(:worker_count)) |> Enum.map(fn num -> worker(ExStatsD, [[worker_num: num]], restart: :permanent, id: :"ExStatsD-worker-#{num}") end)

    supervise(children, strategy: :one_for_one)
  end

end
