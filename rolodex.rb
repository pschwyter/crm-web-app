class Rolodex
	attr_reader :contacts, :selected_contact, :selected_multiple_contacts, :selected_contact_for_deletion

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
		# contact_variables = ["first_name","last_name","email","note","id"]
		@contacts.select do |contact|
			contact.first_name == attribute || contact.last_name == attribute || contact.email == attribute || contact.note == attribute || contact.id == attribute
		end
		# @contacts.select { |contact| contact.send(contact_method) == attribute }
	end

	def set_contact(contact)
		@selected_contact = contact
	end

	# def confirm_deletion(contact)
	# 	if @selected_contact.id == contact.id
	# 		"<a href='/confirmdelete/contact.id'>Yes</a> / <a href='/contacts'>No</a>"
	# 	else
	# 		"<a href='/contacts/delete/<%= contact.id %>Delete</a>"
	# 	end
	# end

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
