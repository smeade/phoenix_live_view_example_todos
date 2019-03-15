defmodule DemoWeb.TodoController do
  use DemoWeb, :controller

  alias Demo.TodoList
  alias Demo.TodoList.Todo

  def index(conn, _params) do
    conn
    |> put_view(DemoWeb.TodoIndexView)
    |> render("index.html")
  end

  def new(conn, _params) do
    changeset = TodoList.change_todo(%Todo{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"todo" => todo_params}) do
    case TodoList.create_todo(todo_params) do
      {:ok, todo} ->
        conn
        |> put_flash(:info, "Todo created successfully.")
        |> redirect(to: Routes.todo_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # def index(conn, _params) do
  #   todos = TodoList.list_todos()
  #   changeset = TodoList.change_todo(%Todo{})
  #   completed_todos_count = Enum.count(TodoList.list_todos(), &(&1.completed))
  #   active_todos_count = Enum.count(TodoList.list_todos(), &(&1.completed == false))
  #   render(conn, "index.html", todos: todos, changeset: changeset,
  #     active_todos_count: active_todos_count, completed_todos_count: completed_todos_count)
  # end

  def active(conn, _params) do
    todos = TodoList.list_active_todos()
    changeset = TodoList.change_todo(%Todo{})
    completed_todos_count = Enum.count(TodoList.list_todos(), &(&1.completed))
    active_todos_count = Enum.count(TodoList.list_todos(), &(&1.completed == false))
    render(conn, "index.html", todos: todos, changeset: changeset,
      active_todos_count: active_todos_count, completed_todos_count: completed_todos_count)
  end

  def completed(conn, _params) do
    todos = TodoList.list_completed_todos()
    changeset = TodoList.change_todo(%Todo{})
    completed_todos_count = Enum.count(TodoList.list_todos(), &(&1.completed))
    active_todos_count = Enum.count(TodoList.list_todos(), &(&1.completed == false))
    render(conn, "index.html", todos: todos, changeset: changeset,
      active_todos_count: active_todos_count, completed_todos_count: completed_todos_count)
  end

  # def new(conn, _params) do
  #   changeset = TodoList.change_todo(%Todo{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  # def create(conn, %{"todo" => todo_params}) do
  #   case TodoList.create_todo(todo_params) do
  #     {:ok, todo} ->
  #       conn
  #       |> put_flash(:info, "Todo created successfully.")
  #       |> redirect(to: Routes.todo_path(conn, :index))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end

  def show(conn, %{"id" => id}) do
    todo = TodoList.get_todo!(id)
    render(conn, "show.html", todo: todo)
  end

  def edit(conn, %{"id" => id}) do
    todo = TodoList.get_todo!(id)
    changeset = TodoList.change_todo(todo)
    render(conn, "edit.html", todo: todo, changeset: changeset)
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    todo = TodoList.get_todo!(id)

    case TodoList.update_todo(todo, todo_params) do
      {:ok, todo} ->
        conn
        |> put_flash(:info, "Todo updated successfully.")
        |> redirect(to: Routes.todo_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", todo: todo, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = TodoList.get_todo!(id)
    {:ok, _todo} = TodoList.delete_todo(todo)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.todo_path(conn, :index))
  end

  def clear_completed(conn, _params) do
    TodoList.clear_completed_todos
    todos = TodoList.list_todos()
    changeset = TodoList.change_todo(%Todo{})
    conn
    |> put_flash(:info, "Todos deleted successfully.")
    |> redirect(to: Routes.todo_path(conn, :index))
  end
end
