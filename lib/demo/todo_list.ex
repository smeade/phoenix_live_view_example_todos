defmodule Demo.TodoList do
  @moduledoc """
  The TodoList context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.TodoList.Todo

  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(Demo.PubSub, @topic)
  end

  def subscribe(todo_id) do
    Phoenix.PubSub.subscribe(Demo.PubSub, @topic <> "#{todo_id}")
  end

  @doc """
  Returns the list of todos.

  ## Examples

      iex> list_todos()
      [%Todo{}, ...]

  """
  def list_todos do
    Repo.all(from t in Todo, order_by: [asc: t.id])
  end

  def list_active_todos do
    from(t in Todo, where: t.completed == false) |> order_by(asc: :id) |> Repo.all
  end

  def list_completed_todos do
    from(t in Todo, where: t.completed) |> order_by(asc: :id) |> Repo.all
  end

  @doc """
  Gets a single todo.

  Raises `Ecto.NoResultsError` if the Todo does not exist.

  ## Examples

      iex> get_todo!(123)
      %Todo{}

      iex> get_todo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_todo!(id), do: Repo.get!(Todo, id)

  @doc """
  Creates a todo.

  ## Examples

      iex> create_todo(%{field: value})
      {:ok, %Todo{}}

      iex> create_todo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_todo(attrs \\ %{}) do
    %Todo{}
    |> Todo.changeset(attrs)
    |> Repo.insert()
    |> notify_subscribers([:todo, :created])
  end

  @doc """
  Updates a todo.

  ## Examples

      iex> update_todo(todo, %{field: new_value})
      {:ok, %Todo{}}

      iex> update_todo(todo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_todo(%Todo{} = todo, attrs) do
    todo
    |> Todo.changeset(attrs)
    |> Repo.update()
    |> notify_subscribers([:todo, :updated])
  end

  @doc """
  Toggles completed status on a todo

  ## Examples

      iex> toggle_complete_todo(todo)
      {:ok, %Todo{}}

      iex> toggle_complete_todo(todo)
      {:error, %Ecto.Changeset{}}

  """
  def toggle_complete_todo(%Todo{} = todo) do
    todo
    |> Todo.changeset(%{completed: !todo.completed})
    |> Repo.update()
    |> notify_subscribers([:todo, :updated])
  end


  @doc """
  Deletes a Todo.

  ## Examples

      iex> delete_todo(todo)
      {:ok, %Todo{}}

      iex> delete_todo(todo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_todo(%Todo{} = todo) do
    todo
    |> Repo.delete()
    |> notify_subscribers([:todo, :deleted])
  end

  @doc """
  Deletes completed Todos

  ## Examples

      iex> delete_todo(todo)
      {:ok, %Todo{}}

      iex> delete_todo(todo)
      {:error, %Ecto.Changeset{}}

  """
  def clear_completed_todos do
    from(t in Todo, where: t.completed) |> Repo.delete_all
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking todo changes.

  ## Examples

      iex> change_todo(todo)
      %Ecto.Changeset{source: %Todo{}}

  """
  def change_todo(%Todo{} = todo) do
    Todo.changeset(todo, %{})
  end

  defp notify_subscribers({:ok, result}, event) do
    Phoenix.PubSub.broadcast(Demo.PubSub, @topic, {__MODULE__, event, result})
    Phoenix.PubSub.broadcast(Demo.PubSub, @topic <> "#{result.id}", {__MODULE__, event, result})
    {:ok, result}
  end

  defp notify_subscribers({:error, reason}, _event), do: {:error, reason}
end
