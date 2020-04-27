defmodule HeadlessBlog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :username, :string
      add :password_hash, :string
      add :properties, :map

      timestamps(default: fragment("NOW()"))
    end

    create unique_index(:users, [:email])
  end
end
