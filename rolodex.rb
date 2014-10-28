class Rolodex
	attr_reader :contacts

	def initialize 
		@contacts = []
		@id = 1000
	end

	def add_contact(contact)
		contact.id = @id
		@id += 1
		@contacts << contact
	end
end
