require 'sinatra'

TASKS = []

get '/' do
  @tasks = TASKS

  erb :index
end

post '/tasks' do
  task_id = SecureRandom.uuid
  task = { id: task_id, name: params[:task] }
  # @task = params['task']
  TASKS << task

  # response.headers['Content-type'] = 'text/vnd.turbo-stream.html'

  redirect '/'
end

get '/tasks/:id/edit' do
  @task = TASKS.find { |task| task[:id] == params[:id] }

  response.headers['Content-Type'] = 'text/vnd.turbo-stream.html'

  erb :edit
end

post '/tasks/:id/edit' do
  @task = TASKS.find { |task| task[:id] == params[:id] }
  # Edit the task name if a task exists
  @task[:name] = params[:task] if @task

  response.headers['Content-Type'] = 'text/vnd.turbo-stream.html'

  erb :update_task_and_clear_form
end

get '/tasks/:id/delete' do
  @tasks = TASKS
  @task = TASKS.find { |task| task[:id] == params[:id] }

  if @task.nil?
    redirect '/'
  end
  
  erb :delete
end

post '/tasks/:id/delete' do
  @task = TASKS.find { |task| task[:id] == params[:id] }

  if @task
    TASKS.delete_if { |task| task[:id] == params[:id] }
    # Optionally, add a success message here
  end

  redirect '/'
end
