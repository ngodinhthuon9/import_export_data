defmodule Ex1.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex1,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Ex1.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:ecto_sql, "~> 3.2"},
      {:postgrex, "~> 0.15"},
      {:xlsxir, "~> 1.6.4"},
      {:nimble_csv, "~> 1.1"}
    ]
  end
end