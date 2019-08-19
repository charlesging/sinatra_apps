require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'
require 'yaml'

before do 
  @users = YAML.load_file('users.yaml')
end

get '/' do
  redirect '/users'
end

not_found do
  redirect '/users'
end

helpers do 

  def interest_count
    count = 0
    @users.each do |name, details|
      count += details[:interests].size
    end
    count
  end

  def other_users
    @users.reject do |name, details|
      name == @user_name
    end.keys
  end
end

get '/users' do 
  erb :users
end

get '/users/:name' do
  @user_name = params['name'].to_sym
  @email = @users[@user_name][:email]
  @interests = @users[@user_name][:interests].join(", ")

  erb :user
end


