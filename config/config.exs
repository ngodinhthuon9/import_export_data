import Config

config :ex1, Ex1.Repo,
  database: "ex1_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"


config :ex1, ecto_repos: [Ex1.Repo]
