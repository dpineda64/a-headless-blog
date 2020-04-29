defmodule HeadlessBlog.Content.PostsTest do
  use HeadlessBlog.DataCase

  alias HeadlessBlog.Content.Posts
  alias HeadlessBlog.Content.Posts.Post

  describe "posts" do
    import HeadlessBlog.Factory

    @valid_attrs %{
      content: "some content",
      images: [],
      properties: %{},
      status: "draft",
      title: "Some Name",
      author: build(:user)
    }
    @update_attrs %{
      content: "some updated content",
      images: [],
      properties: %{}
    }
    @invalid_attrs %{
      content: nil,
      images: nil,
      properties: nil,
      slug: nil,
      author: nil
    }

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Posts.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = new_post()
      assert Posts.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = new_post()
      assert Posts.get_post!(post.slug) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Posts.create_post(@valid_attrs)
      assert post.content == "some content"
      assert post.images == []
      assert post.title == "Some Name"
      assert post.properties == %{}
      assert post.slug == "some-name"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = new_post() |> Repo.preload(:author)
      assert {:ok, %Post{} = post} = Posts.update_post(post, @update_attrs)
      assert post.content == "some updated content"
      assert post.images == []
      assert post.properties == %{}
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = new_post()
      assert {:error, %Ecto.Changeset{}} = Posts.update_post(post, @invalid_attrs)
      assert post == Posts.get_post!(post.slug)
    end

    test "delete_post/1 deletes the post" do
      post = new_post()
      assert {:ok, %Post{}} = Posts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.slug) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Posts.change_post(post)
    end

    defp new_post(attrs \\ %{}) do
      HeadlessBlog.UnPreload.forget(insert(:post, attrs), :author)
    end
  end
end
