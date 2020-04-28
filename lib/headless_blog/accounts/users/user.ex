defmodule HeadlessBlog.Accounts.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  import Ecto.Changeset

  use Pow.Extension.Ecto.Schema,
    extensions: [PowResetPassword]

  @required_fields ~w(username email)a
  @optional_fields ~w(properties)a

  schema "users" do
    field :email, :string
    field :properties, :map
    field :username, :string
    pow_user_fields()

    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> pow_extension_changeset(attrs)
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:email)
  end
end
