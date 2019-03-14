defmodule Tasks2Web.TaskController do
  use Tasks2Web, :controller

  alias Tasks2.Tasks
  alias Tasks2.Tasks.Task
  alias Tasks2.Users
  alias Tasks2.Mentorships
  alias Tasks2.TimeBlocks

  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    tasks = Enum.map(tasks, fn task ->
      user = Users.get_user(task.user_id)
      %{task | user_id: user.email}
    end)
    render(conn, "index.html", tasks: tasks)
  end

  def report(conn, %{"id" => id}) do

    mentorships = Mentorships.get_mentorships(id)
    underlings = Enum.map(mentorships, fn x -> Users.get_user!(x.underling_id).email end)

    IO.inspect(underlings)

    users = Enum.map(underlings, fn underling -> 
      Users.get_user_by_email(underling)
    end)

    tasks = Enum.map(users, fn user ->
      Users.get_tasks_by_user_id(user.id)
    end)

    tasks = List.flatten(tasks)

    tasks = Enum.map(tasks, fn task ->
      user = Users.get_user(task.user_id)
      %{task | user_id: user.email}
    end)

    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Tasks.change_task(%Task{})

    users = Mentorships.get_mentorships(conn.assigns.current_user.id)

    users = Enum.map(users, fn user -> 
      Users.get_user(user.underling_id).email
    end)

    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, %{"task" => task_params}) do

    email = if (task_params["user_id"] != nil) do
      task_params["user_id"]
    else 
      nil
    end

    user = if (email != nil) do
      Users.get_user_by_email(email)
    else
      nil
    end

    task_params = if (user != nil) do
      Map.put(task_params, "user_id", user.id)
    else
      task_params
    end    

    users = Mentorships.get_mentorships(conn.assigns.current_user.id)

    users = Enum.map(users, fn user -> 
      Users.get_user(user.underling_id).email
    end)

    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)
        changeset = if Map.has_key?(changeset.changes, :user_id) do
          user = Users.get_user(changeset.changes.user_id)
          changes = changeset.changes
          changes = %{changes | user_id: user.email}
          %{changeset | changes: changes}
        else 
          changeset
        end
        render(conn, "new.html", changeset: changeset, users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    user = Users.get_user(task.user_id)
    task = %{task | user_id: user.email}

    time_blocks = TimeBlocks.get_blocks_by_task_id(id)

    task = Map.put(task, :time_blocks, time_blocks)

    IO.inspect(task)

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
          %{changeset | changes: changes}
        else
          changes = changeset.changes
          changes = Map.put(changes, :user_id, email)
          %{changeset | changes: changes}
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
