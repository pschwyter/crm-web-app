require 'sinatra'
require './contacts.rb'
require './rolodex.rb'

$rolodex = Rolodex.new

get "/" do
	@crm_app_name = "Bitmaker CRM"
	erb :index
end

get "/contacts" do
  erb :contacts
end

get "/contacts/new" do
	erb :new_contact
end

get "/contacts/edit/:id" do
	id = params[:id].to_i
	puts params
	contact_to_edit = $rolodex.find_contact(id)[0]
	puts contact_to_edit
	$rolodex.set_contact(contact_to_edit)
	erb :edit_contact
end


get "/contacts/delete/:id" do
	id = params[:id].to_i
	contact_to_delete = $rolodex.find_contact(id)[0]
	$rolodex.delete_contact(contact_to_delete)
	#erb :delete_contact
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
	$rolodex.edit_contact(params[:first_name],params[:last_name],params[:email],params[:note])
	redirect to('/contacts')
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

