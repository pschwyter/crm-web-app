#key word arguments for classes

class Cat
	def initialize(name, favorite_food:)
		@name = name
		@favorite_food = favorite_food
		@hungry = true
end

kitty = Cat.new("kitty", favorite_food: "chicken")

# system %Q

def offer(thing)
	if thing == @favorite_food
		eat
	elsif thing == @favorite_toy
		play
	else
		reject
	end
end

#have private methods for ear, play and reject

#Refactoring <--- book