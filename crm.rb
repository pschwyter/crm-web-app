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

post "/contacts" do
	puts params
	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
	$rolodex.add_contact(new_contact)
	redirect to('/contacts')
end