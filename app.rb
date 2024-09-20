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

  erb :tasks
end
