defmodule ReleaseAdmin.RepositoryTest do
  use ReleaseAdmin.DataCase
  import Ecto.Changeset
  import ReleaseAdmin.Factory

  alias ReleaseAdmin.{Repo, Repository}

  describe "validations" do
    test "validates uniqueness of repository url" do
      attrs = %{
        repository_url: "https://github.com/jeremyjh/dialyxir",
        polling_interval: 60,
        user_id: 1
      }

      insert(:repository, repository_url: "https://github.com/jeremyjh/dialyxir")

      assert {:error, reason} =
               %Repository{}
               |> Repository.changeset(attrs)
               |> Repo.insert()

      assert %{repository_url: ["has already been taken"]} = errors_on(reason)
    end

    test "validates repository_url is required" do
      assert {:error, reason} =
               %Repository{}
               |> Repository.changeset(%{})
               |> Repo.insert()

      assert %{repository_url: ["can't be blank"]} = errors_on(reason)
    end

    test "validates polling_interval is required" do
      assert {:error, reason} =
               %Repository{}
               |> Repository.changeset(%{})
               |> Repo.insert()

      assert %{polling_interval: ["can't be blank"]} = errors_on(reason)
    end
  end

  test "parses correctly repository url into owner/repo name" do
    attrs = %{
      repository_url: "https://github.com/jeremyjh/dialyxir",
      user_id: 1,
      polling_interval: 60
    }

    changeset = Repository.changeset(%Repository{}, attrs)

    assert get_change(changeset, :owner) == "jeremyjh"
    assert get_change(changeset, :name) == "dialyxir"
  end
end
