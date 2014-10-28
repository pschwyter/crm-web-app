class Contact
	attr_accessor :id, :first_name, :last_name, :email, :note

	def initialize(first_name, last_name, email, note)
		@first_name = first_name
		@last_name = last_name
		@email = email
		@note = note
	end

	def to_s
		"ID: #{@id}, Contact: #{@first_name} #{@last_name}, <#{@email}>\nNote: #{@note}"
	end
end