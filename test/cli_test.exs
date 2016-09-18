defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [parse_args: 1, sort_into_ascending_order: 1]

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

  test "sort ascending order in the right way" do
    result = sort_into_ascending_order(fake_created_at_list(["a", "c", "b"]))
    issues = for issue <- result, do: Map.get(issue, "created_at")
    assert issues == ~w{a b c}
  end

  defp fake_created_at_list(values) do
    for value <- values,
      do: %{"created_at" => value, "other_unused_data" => "xxx"}
  end
end
