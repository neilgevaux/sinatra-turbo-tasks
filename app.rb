require 'sinatra'

TASKS = []

get '/' do
  @tasks = TASKS
  erb :index
end

post '/tasks' do
  @task = params['task']
  TASKS << @task

  response.headers['Content-type'] = 'text/vnd.turbo-stream.html'

  erb :task_add, layout: false
end

put '/tasks/:index' do
  @task = TASKS[index]
  @index = index

  erb :task_update, layout:false
end
