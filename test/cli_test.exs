defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [parse_args: 1]

  test ":help returned by option parsing -h and --help options" do
    assert parse_args(["-h",     "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "three values return if three were given" do
    assert parse_args(["lonamiaec", "elixir_issues", "10"]) == {"lonamiaec", "elixir_issues", 10}
  end

  test "Two values and default count returned if only two values were given" do
    assert parse_args(["lonamiaec", "elixir_issues"]) == {"lonamiaec", "elixir_issues", 4}
  end
end
