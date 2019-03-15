defmodule DemoWeb.TodoLive.Edit do
  use Phoenix.LiveView

  alias DemoWeb.TodoLive
  alias DemoWeb.Router.Helpers, as: Routes
  alias Demo.TodoList

  def mount(%{path_params: %{"id" => id}}, socket) do
    todo = TodoList.get_todo!(id)

    {:ok,
     assign(socket, %{
       count: 0,
       todo: todo,
       changeset: TodoList.change_todo(todo)
     })}
  end

  def render(assigns), do: DemoWeb.TodoView.render("edit.html", assigns)

  def handle_event("validate", %{"todo" => params}, socket) do
    changeset =
      socket.assigns.todo
      |> Demo.TodoList.change_todo(params)
      |> Map.put(:action, :update)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"todo" => todo_params}, socket) do
    case TodoList.update_todo(socket.assigns.todo, todo_params) do
      {:ok, todo} ->
        {:stop,
         socket
         |> put_flash(:info, "Todo updated successfully.")
         |> redirect(to: Routes.live_path(socket, TodoLive.Index))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
