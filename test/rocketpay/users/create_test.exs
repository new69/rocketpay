defmodule Rocketpay.User.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.User.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Jefferson",
        password: "123456",
        nickname: "GG",
        email: "test@test.com",
        age: 34
      }

      {:ok, %User{id: user_id}} = Rocketpay.create_user(params)

      user = Repo.get(User, user_id)

      assert %User{name: "Jefferson", age: 34, id: ^user_id} = user
    end

    test "when ther are invalid, returns an error" do
      params = %{
        name: "Jefferson",
        nickname: "GG",
        email: "test@test.com",
        age: 13
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{age: ["must be greater than or equal to 18"], password: ["can't be blank"]}

      assert errors_on(changeset) == expected_response
    end
  end
end
