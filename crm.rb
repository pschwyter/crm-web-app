require 'sinatra'
require "sinatra/reloader" if development?
require './contacts.rb'
require './rolodex.rb'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

$rolodex = Rolodex.new

get "/" do
	@crm_app_name = "Bitmaker CRM"
	erb :index
end

get "/contacts" do
	params[:page_name] = "Contacts / <a href=/contacts/new><span class='glyph-add-icon glyphicon glyphicon-plus'></span></a>"
	erb :contacts
end

get "/contacts/new" do
	params[:page_name] = "Add new contact"
	erb :new_contact
end

get "/search" do
	params[:page_name] = "Search Result"
	puts params
	erb :search_contact
end

get "/contacts/view/:id" do
	id = params[:id].to_i
	puts params
	contact_to_view = $rolodex.find_contact(id)
	if contact_to_view
		$rolodex.set_contact(contact_to_view)
		puts $rolodex.selected_contact.class
		erb :view_contacts
	else
		erb :not_found
	end
end

get "/contacts/delete/:id" do
	id = params[:id].to_i
	contact_to_delete = $rolodex.find_contact(id)
	if contact_to_delete
		$rolodex.delete_contact(contact_to_delete)
		redirect to('/contacts')
	else
		erb :not_found
	end
end

#Maybe Implement this at some point??? Has to be used in a form
# delete "/contacts/delete/:id" do
# 	id = params[:id].to_i
# 	contact_to_delete = $rolodex.find_contact(id)
# 	$rolodex.delete_contact(contact_to_delete)
# 	redirect to('/contacts')
# end

post "/contacts" do
	puts params
	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
	$rolodex.add_contact(new_contact)
	redirect to('/contacts')
end

post "/contacts_edit" do
	puts params
	puts $rolodex.selected_contact
	$rolodex.edit_contact(params[:first_name],params[:last_name],params[:email],params[:note])
	redirect to('/contacts')
end

post "/search" do
	attribute = params[:attribute]
	puts attribute
	contacts_to_display = $rolodex.find_contacts(attribute)
	puts contacts_to_display
	$rolodex.set_multiple_contacts(contacts_to_display)
	params[:page_name] = "Search Result"
	erb :search_contact
end

#Only for debugging
post "/contacts_generate" do
	new_contact = Contact.new("Phil", "Schwyter", "pschwyter90@gmail.com", "student")
	$rolodex.add_contact(new_contact)
	new_contact = Contact.new("Bob", "Smith", "bob@gmail.com", "student")
	$rolodex.add_contact(new_contact)
	new_contact = Contact.new("Jerry", "Jackson", "jerry@gmail.com", "student")
	$rolodex.add_contact(new_contact)
	new_contact = Contact.new("Frank", "Fenster", "frank@gmail.com", "student")
	$rolodex.add_contact(new_contact)
	new_contact = Contact.new("Laura", "Lincoln", "laura@gmail.com", "student")
	$rolodex.add_contact(new_contact)
	redirect to('/contacts')
end

