# display homepage
get '/' do
  # Look in app/views/index.erb
  erb :index
end

# submit login info
post '/' do
  @email = params[:email]
  @password = params[:password]
  @user = User.authenticate(@email,@password)
  if @user
    #set session
    session[:user_id] = @user.id
    puts session[:user_id].to_s + "--------------------------"
    @greetuser = "Hello!"
    redirect "/dashboard"
  else
    @loginerror = "Login failed. Check your email / password & try again"
    erb :index
  end
end

# submit signup info
post '/signup' do
  @first_name = params[:first_name]
  @last_name = params[:last_name]
  @email = params[:email]
  @birthdate = params[:birthdate]
  @password = params[:password]

  @user = User.new(
    first_name: @first_name,
    last_name: @last_name,
    email: @email,
    birthdate: @birthdate,
  )
  @user.password = params[:password]
  @user.save!

  session[:user_id] = @user.id
  puts "printing out userid session"
  puts session[:user_id]


  redirect "/dashboard"

  # if @user
  #   session[:user_id] = @user.id
  #   redirect_to("/dashboard")
  # else
  #   @signuperror = "Sorry, I can't sign you up with the information provided."
  #   erb :index
  # end
  erb :index
end

# user dashboard
get '/dashboard' do
  # check if user is logged in (should already have session id)
  if session[:user_id] == nil
    @loginerror = "Please login first."
     erb :index
  else
    @event = Event.all
    erb :dashboard
  end
end

get "/logout" do 
  session.clear
  redirect '/'
end

post '/addevent' do
  Event.create(name: params[:name], location: params[:location], starts_at: params[:starts_at], ends_at: params[:ends_at], user_id: session[:user_id])
end

get '/delete/:id' do
  Event.find(params[:id]).destroy
  redirect '/dashboard'
end

get '/attend/:id' do
  EventAttendance.create(user_id: session[:user_id], event_id: params[:id])
  redirect '/dashboard'
end

get '/user/:id' do
  @loggedinuserid = session[:user_id]
  @user = User.find(params[:id])
  # same as @event = Event.find_all_by_user_id(params[:id])
  @events = @user.events

  if @loggedinuserid == @user.id
    @sameuser = true
  else
    @sameuser = false
  end

  erb :user
end

get '/edit/:id' do
  @event = Event.find(params[:id])
  erb :editevent
end

post '/edit/:id' do
  Event.find(params[:id]).update_attributes(name: params[:name], location: params[:location], starts_at: params[:starts_at], ends_at: params[:ends_at])
  redirect "/dashboard"
end
