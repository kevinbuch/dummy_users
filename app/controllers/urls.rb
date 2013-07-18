get '/' do
  @urls = Url.all
  erb :index
end

get '/url/:url_id' do
  @url = Url.find(params[:url_id])
  erb :url
end

get '/z/:short_url' do
  @url = Url.find_by_shortened_url(params[:short_url])
  @url.add_click
  redirect to(@url.original)
end

post '/url/create' do
  params[:url][:user_id] = session[:user_id]
  @url = Url.create(params[:url])
  if @url.valid?
    redirect to("/")
  else
    @urls = Url.all
    erb :index
  end
end
