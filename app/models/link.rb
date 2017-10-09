class Link < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!\\
	validates :long_link, presence: true
	validates :long_link, uniqueness: {case_sensitive: false, message: "was shortened before"}
	validates :long_link, format: {with: (URI::regexp(['http', 'https'])), message: "format is not good"}
	
	def shorten
		newlink = []
		6.times do 
		a = ("A".."Z").to_a + ("a".."z").to_a + (0..9).to_a
		newlink << a.sample
		end
		self.short_link = newlink.join
		self.counter = 1
	end

	def update_counter
		self.counter += 1
		self.save
	end

	def display_total
		total = 0
		self.each do |number|
			total += number
		end
	end
end

