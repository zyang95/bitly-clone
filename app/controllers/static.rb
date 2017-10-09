get '/' do
 #  "<h1>i love you</h1>
 # <ul>
 # 	<li>hello</li>
 # 	<li> darkness</li>
 # 	</ul>"
 		@total = 0
		Link.all.each do |number|
			@total += number.counter
		end
		#p @total
  erb :"static/index"

end

# get	'/meow' do
#   erb :"static/meow"
# end


post '/urls' do
	# if params["long_link"] =~ /\w*:?\/*\w+\.\w+\.?\w+./
		# if Link.find_by(long_link: params["long_link"]) == nil
	url = Link.new(long_link: params["long_link"])
	url.shorten
	if url.save
		@final_input = "localhost:9393/" + url.short_link
		# else 
		# 	url = Link.find_by(long_link: params["long_link"])
		# 	url.update_counter
		# 	@final_input = "localhost:9393/" + url.short_link
		# 	@long_link = url.long_link
		# end
	elsif Link.find_by(long_link: params["long_link"]) != nil
		url = Link.find_by(long_link: params["long_link"])
		@final_input = "localhost:9393/" + url.short_link
	else

		@final_input = url.errors.full_messages.join(',')	
		# "Please put a valid url"
	end
	# Post.all
end


get '/tour' do
	erb :"static/meow"
end

get '/:short_url' do
	a = Link.find_by(short_link: params[:short_url])
	if a
		a.update_counter
	
		redirect(a.long_link)
	else
		redirect '/'
	end
end
	




