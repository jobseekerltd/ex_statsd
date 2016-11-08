defmodule ExStatsD.ConfigurationTest do
  use ExUnit.Case, async: true
  alias ExStatsD.Configuration

  test "get configuration value" do
    assert Configuration.get(:namespace) == "test"
  end

  test "get default value" do
    assert Configuration.get(:host) == "127.0.0.1"
  end

  test "get undefined value with no default is nil" do
    assert Configuration.get(:undefined) == nil
  end

end
