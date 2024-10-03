require 'sinatra'

TASKS = { "list" => [] }

get '/' do
  @tasks = TASKS
  erb :index
end

# New route to display tasks as a list
get '/tasks' do
  @tasks = TASKS
  response.headers['Content-type'] = 'text/vnd.turbo-stream.html'
  erb :tasks
end

post '/tasks' do
  task_name = params[:task_name]
  due_date = params[:due_date]
  complete = params[:complete] == 'on'

  TASKS["list"] << {
    name: task_name,
    due_date: due_date,
    complete: complete
  }

  # Update the task list and send back Turbo Stream updates
  @tasks = TASKS
  response.headers['Content-type'] = 'text/vnd.turbo-stream.html'
  erb :tasks
end

post '/tasks/edit/:id' do
  task_id = params[:id].to_i
  @task = TASKS["list"][task_id]

  if @task
    @task[:name] = params[:task_name]
    @task[:due_date] = params[:due_date]
    @task[:complete] = params[:complete] == 'on'
  end

  # Update the task list and send back Turbo Stream updates
  @tasks = TASKS
  response.headers['Content-type'] = 'text/vnd.turbo-stream.html'
  erb :tasks
end
