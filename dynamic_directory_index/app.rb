require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'

get '/' do
  @files = Dir.glob('public/*').map { |f| File.basename(f) }.sort
  @files.reverse! if params[:order] == "reverse"
  
  erb :home
end