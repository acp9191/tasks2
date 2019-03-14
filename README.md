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
  * The relationship between a manager and an underling is called a "mentorship"
  * Anyone can view the list of mentorships, create a new mentorship, delete a mentorship, or edit a mentorship
  * A User can only have one manager
  * A User cannot be their own manager
  * A User must be a manager in order to have underlings
  * A User's underling cannot be his or her manager
  * Once a user is made a manager, they cannot be demoted (made not a manager)
  * Only a manager can see the task-report page
  * Only a manager can assign tasks, and they can only be assigned to their underlings
  * The task report page shows a subset of all the tasks 
  * Only the User who is assigned to a task can add or delete time blocks
  * Time blocks cannot be edited
  * Time blocks can only be seen on a task's "show" page
  * Date times are shown in iso8601 format
