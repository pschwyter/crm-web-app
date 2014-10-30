require 'sinatra'
require "sinatra/reloader" if development?
require './contacts.rb'
require './rolodex.rb'

$rolodex = Rolodex.new

get "/" do
	@crm_app_name = "Bitmaker CRM"
	params[:page_name] = "Main Menu"
	erb :index
end

get "/contacts" do
	params[:page_name] = "Contacts"
	erb :contacts
end

get "/contacts/new" do
	params[:page_name] = "Add new contact"
	erb :new_contact
end

get "/search" do
	params[:page_name] = "Search for Contact"
	erb :search_contact
end

get "/contacts/view/:id" do
	id = params[:id].to_i
	puts params
	contact_to_view = $rolodex.find_contact(id)
	# params[:page_name] = "#{contact_to_view.first_name} #{contact_to_view.last_name}"
	$rolodex.set_contact(contact_to_view)
	# puts $rolodex.selected_contact
	puts $rolodex.selected_contact.class
	erb :view_contacts
end

# get "/contacts/edit/:id" do
# 	id = params[:id].to_i
# 	puts params
# 	contact_to_edit = $rolodex.find_contact(id)
# 	puts contact_to_edit
# 	$rolodex.set_contact(contact_to_edit)
# 	@oage_name = "Edit Contact"
# 	erb :edit_contact
# end

get "/contacts/delete/:id" do
	id = params[:id].to_i
	contact_to_delete = $rolodex.find_contact(id)
	$rolodex.delete_contact(contact_to_delete)
	redirect to('/contacts')
end

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
	contact_method = params[:contact_method]
	attribute = params[:attribute]
	contacts_to_display = $rolodex.find_contacts(attribute,contact_method)
	$rolodex.set_multiple_contacts(contacts_to_display)
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

