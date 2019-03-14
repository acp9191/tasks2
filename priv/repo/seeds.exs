# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tasks2.Repo.insert!(%Tasks2.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Tasks2.Repo

alias Tasks2.Users.User

Repo.insert!(%User{email: "alice@example.com", is_manager: true})
Repo.insert!(%User{email: "bob@example.com", is_manager: false})
Repo.insert!(%User{email: "charlie@example.com", is_manager: false})

alias Tasks2.Tasks.Task

Repo.insert!(
  %Task{
    description: "Foobar", 
    is_completed: false,
    title: "Foobar", 
    user_id: 2
  }
)

alias Tasks2.TimeBlocks.TimeBlock

Repo.insert!(
  %TimeBlock{
    start: DateTime.truncate(DateTime.utc_now(), :second), 
    end: DateTime.add(DateTime.truncate(DateTime.utc_now, :second), 3600, :second), 
    task_id: 1
  }
)

Repo.insert!(
  %TimeBlock{
    start: DateTime.truncate(DateTime.utc_now(), :second), 
    end: DateTime.add(DateTime.truncate(DateTime.utc_now, :second), 36, :second), 
    task_id: 1
  }
)

Repo.insert!(
  %TimeBlock{
    start: DateTime.truncate(DateTime.utc_now(), :second), 
    end: %DateTime{
      year: 2019,
      month: 10,
      day: 10,
      hour: 10,
      minute: 10,
      second: 10,
      time_zone: "Etc/UTC",
      zone_abbr: "EST",
      utc_offset: 0,
      std_offset: 0
    },
    task_id: 1
  }
)

alias Tasks2.Mentorships.Mentorship

Repo.insert!(%Mentorship{manager_id: 1, underling_id: 2})
Repo.insert!(%Mentorship{manager_id: 1, underling_id: 3})