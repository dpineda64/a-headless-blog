defmodule HeadlessBlog.Accounts.UsersTest do
  use HeadlessBlog.DataCase

  alias HeadlessBlog.Accounts.Users

  describe "users" do
    alias HeadlessBlog.Accounts.Users.User

    @test_email "test@test.com"
    @uptest_email "test@test.com"

    @valid_attrs %{
      email: @test_email,
      properties: %{},
      username: "some username",
      validation: true,
      password: "test_pwd",
      password_confirmation: "test_pwd"
    }
    @update_attrs %{
      email: @uptest_email,
      properties: %{},
      username: "some updated username",
      current_password: "test_pwd"
    }
    @invalid_attrs %{email: nil, properties: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_user()

      %{user | password: nil}
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create_user(@valid_attrs)
      assert user.email == @test_email
      assert user.properties == %{}
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Users.update_user(user, @update_attrs)
      assert user.email == @uptest_email
      assert user.properties == %{}
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
