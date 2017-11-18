#Frontend Routes
/login
/signup

/tasks
/tasks/new
/tasks/:id
/tasks/:id/edit

/tasks/:id/subtasks
/tasks/:id/subtasks/new
/tasks/:id/subtasks/:id
/tasks/:id/subtasks/:id/edit

/projects/new
/projects/:id
/projects/:id/edit

/projects/:id/tasks
/projects/:id/tasks/new
/projects/:id/tasks/:id
/projects/:id/tasks/:id/edit

/projects/:id/tasks/:id/subtasks
/projects/:id/tasks/:id/subtasks/new
/projects/:id/tasks/:id/subtasks/:id
/projects/:id/tasks/:id/subtasks/:id/edit

GET /api/users
POST /api/users

GET /api/tasks
POST /api/tasks
SHOW /api/tasks/:id
PATCH /api/tasks/:id
DELETE /api/tasks/:id

GET /api/tasks/:id/subtasks
POST /api/tasks/:id/subtasks
SHOW /api/tasks/:id/subtasks/:id
PATCH /api/tasks/:id/subtasks/:id
DELETE /api/tasks/:id/subtasks/:id

GET api/projects
POST api/projects
SHOW api/projects/:id
PATCH api/projects/:id
DELETE api/projects/:id

GET api/projects/:id/tasks
POST api/projects/:id/tasks
SHOW api/projects/:id/tasks/:id
PATCH api/projects/:id/tasks/:id
DELETE api/projects/:id/tasks/:id

GET api/projects/:id/tasks/:id/subtasks
POST api/projects/:id/tasks/:id/subtasks
SHOW api/projects/:id/tasks/:id/subtasks/:id
PATCH api/projects/:id/tasks/:id/subtasks/:id
DELETE api/projects/:id/tasks/:id/subtasks/:id
