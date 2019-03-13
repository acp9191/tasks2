# Tasks2

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Design Choices

  * The relationship between Users and Tasks is one-to-many
  * Used user id to related the two entities
  * Transformed user id to it's respective email address so the id is never exposed to the user
  * Handled most of the logic in the Task Controller file
  * Validated 15 minute increments in task.ex file
  * None of the inputs fields can ever be empty
  * User email must exist in the database in order for a task to be assigned to them
  * A User can only have one manager
  * A User cannot be their own manager
  * A User must be a manager in order to have underlings
  * A User's underling cannot be his or her manager
  * Only a manager can see the task-report page
  * Only the User who is assigned to a task can add or delete time blocks
  * Time blocks cannot be edited
  * Time blocks can only be seen on a task's "show" page
  * The page must be refreshed in order to view additions or deletions to the list of time blocks
