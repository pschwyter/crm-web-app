class Rolodex
	attr_reader :contacts, :selected_contact, :selected_multiple_contacts

	def initialize 
		@contacts = []
		@id = 1000
	end

	def add_contact(contact)
		contact.id = @id
		@id += 1
		@contacts << contact
	end

	def find_contact(*args)
		find_contacts(*args).first
	end

	def find_contacts(attribute, contact_method="id")
		@contacts.select { |contact| contact.send(contact_method) == attribute }
	end

	def set_contact(contact)
		@selected_contact = contact
	end

	def set_multiple_contacts(contacts)
		@selected_multiple_contacts = contacts
	end

	def edit_contact(first_name, last_name, email, note)
		@selected_contact.first_name = first_name
		@selected_contact.last_name = last_name
		@selected_contact.email = email
		@selected_contact.note = note
	end

	def delete_contact(contact)
		id = contact.id
		@contacts.delete_if { |contact| contact.id == id}
	end
end
