defmodule Tasks1Web.TaskController do
  use Tasks1Web, :controller

  alias Tasks1.Tasks
  alias Tasks1.Tasks.Task
  alias Tasks1.Users

  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    tasks = Enum.map(tasks, fn task ->
      user = Users.get_user(task.user_id)
      %{task | user_id: user.email}
    end)
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Tasks.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"task" => task_params}) do
    email = task_params["user_id"]
    user = Users.get_user_by_email(email)

    task_params = if (user != nil) do
      Map.put(task_params, "user_id", user.id)
    else
      task_params
    end

    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        changeset = if Map.has_key?(changeset.changes, :user_id) do
          user = Users.get_user(changeset.changes.user_id)
          changes = changeset.changes
          changes = %{changes | user_id: user.email}
          changeset = %{changeset | changes: changes}
        end
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    user = Users.get_user(task.user_id)
    task = %{task | user_id: user.email}
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    user = Users.get_user(Integer.to_string(task.user_id))
    task = %{task | user_id: user.email}

    changeset = Tasks.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)
    email = task_params["user_id"]
    user = Users.get_user_by_email(email)

    task_params = if (user != nil) do
      Map.put(task_params, "user_id", user.id)
    else
      task_params
    end
    
    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        task = %{task | user_id: email}
        changeset = if Map.has_key?(changeset.changes, :user_id) do
          user = Users.get_user(changeset.changes.user_id)
          changes = changeset.changes
          changes = %{changes | user_id: user.email}
          changeset = %{changeset | changes: changes}
        else
          changes = changeset.changes
          changes = Map.put(changes, :user_id, email)
          changeset = %{changeset | changes: changes}
        end
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end
end
