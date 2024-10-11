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

  erb :edit
end

post '/tasks/:id' do
  @task = TASKS.find { |task| task[:id] == params[:id] }
  @task[:name] = params[:task] if @task

  redirect '/'
end
