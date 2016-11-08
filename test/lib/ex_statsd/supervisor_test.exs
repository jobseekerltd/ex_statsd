defmodule ExStatsD.SupervisorTest do
  use ExUnit.Case, async: false

  describe "with multiple workers" do
    setup do
      Application.put_env(:ex_statsd, :worker_count, 5)
      {:ok, pid} = ExStatsD.Supervisor.start_link([])

      on_exit fn ->
        Application.put_env(:ex_statsd, :worker_count, 1)
      end

      {:ok, pid: pid}
    end

    test "it starts 5 workers" do
      %{specs: count} = Supervisor.count_children(ExStatsD.Supervisor)
      assert count == 5
    end

    test "assigns messages between workers" do
      :random.seed {0, 0, 0}
      put_messages(10)

      assert sent(:"Elixir.ExStatsD_1") != []
      assert sent(:"Elixir.ExStatsD_2") != []
      assert sent(:"Elixir.ExStatsD_3") != []
      assert sent(:"Elixir.ExStatsD_4") != []
      assert sent(:"Elixir.ExStatsD_5") != []
    end
  end

  defp put_messages(0), do: nil
  defp put_messages(n) do
    ExStatsD.histogram(n, "histogram")
    Process.sleep(10)
    put_messages(n - 1)
  end

  defp state(name) do
    :sys.get_state(name)
  end

  defp sent(name), do: state(name).sink

end
