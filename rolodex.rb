class Rolodex
	attr_reader :contacts, :selected_contact

	def initialize 
		@contacts = []
		@id = 1000
	end

	def add_contact(contact)
		contact.id = @id
		@id += 1
		@contacts << contact
	end

	def find_contact(id)
		@contacts.select { |contact| contact.id == id }
	end

	def set_contact(contact)
		@selected_contact = contact
		@selected_contact
	end

	def edit_contact(first_name,last_name,email,note)
		@selected_contact.first_name = first_name
		@selected_contact.last_name = last_name
		@selected_contact.email = email
		@selected_contact.note = note
	end
end
