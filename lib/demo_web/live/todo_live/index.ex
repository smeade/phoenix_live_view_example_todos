defmodule DemoWeb.TodoLive.Index do
  use Phoenix.LiveView

  alias DemoWeb.TodoLive
  alias DemoWeb.Router.Helpers, as: Routes
  alias Demo.TodoList
  alias DemoWeb.TodoView
  alias Demo.TodoList.Todo

  def mount(_session, socket) do
    if connected?(socket), do: Demo.TodoList.subscribe()
    {:ok, fetch(socket)}
  end

  def render(assigns), do: TodoView.render("index.html", assigns)

  defp fetch(socket) do
    assign(socket, %{
      count: 0,
      todos: TodoList.list_todos(),
      changeset: TodoList.change_todo(%Todo{})
    })
  end

  def handle_info({TodoList, [:todo | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_event("delete_todo", id, socket) do
    todo = TodoList.get_todo!(id)
    {:ok, _todo} = TodoList.delete_todo(todo)

    {:noreply, socket}
  end

  def handle_event("save", %{"todo" => todo_params}, socket) do
    case TodoList.create_todo(todo_params) do
      {:ok, todo} ->
        {:noreply, fetch(socket)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
