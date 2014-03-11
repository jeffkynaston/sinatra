require 'sinatra'
require 'slim'
require 'sass'
require './song'
require 'sinatra/reloader' if development?

configure do
	enable :sessions
	set :username, 'frank'
	set :password, 'sinatra'
end

get('/styles.css'){ scss :styles }

get '/' do
	slim :home
end

get '/login' do
	slim :login
end

post '/login' do
	if params[:username] == settings.username && params[:password] == settings.password
		session[:admin] = true
		redirect to('/songs')
	else
		slim :login
	end
end

get '/about' do
	@title = "All About This Website"
	slim :about
end

get '/contact' do
	@title = "Contact the Webmaster"
	slim :contact
end

get '/logout' do
	session.clear
	redirect to('/login')
end



not_found do
	slim :not_found
end

get '/set/:name' do
	session[:name] = params[:name]
end

get '/get/hello' do
	"Hello #{session[:name]}"
end

get '/fake-error' do
	status 500
	"There’s nothing wrong, really :P"
end

__END__
