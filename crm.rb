require 'sinatra'
require "sinatra/reloader" if development?
require 'data_mapper'
require './contacts.rb'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
	include DataMapper::Resource

	property :id, Serial
	property :first_name, String
	property :last_name, String
	property :email, String
	property :note, String

end

DataMapper.finalize
DataMapper.auto_upgrade!

get "/" do
	@crm_app_name = "Bitmaker CRM"
	erb :index
end

get "/contacts" do
	params[:page_name] = "Contacts / <a href=/contacts/new><span class='glyph-add-icon glyphicon glyphicon-plus'></span></a>"
	@contacts = Contact.all
	erb :contacts
end

get "/contacts/new" do
	params[:page_name] = "Add new contact"
	erb :new_contact
end

get "/search" do
	params[:page_name] = "Search Result"
	erb :search_contact
end

get "/contacts/view/:id" do
	id = params[:id].to_i
	@contact_to_view = Contact.get(id)
	if @contact_to_view
		erb :view_contacts
	else
		erb :not_found
	end
end

get "/contacts/delete/:id" do
	id = params[:id].to_i
	contact_to_delete = Contacts.get(id)
	if contact_to_delete
		contact_to_delete.destroy
		redirect to('/contacts')
	else
		erb :not_found
	end
end

post "/contacts" do
	contact = Contact.create(
		:first_name => params[:first_name],
		:last_name => params[:last_name],
		:email => params[:email],
		:note => params[:note]
	)
	redirect to('/contacts')
end

post "/contacts/:id/edit" do
	id = params[:id].to_i
	contact_to_edit = Contact.get(id)
	contact_to_edit.update(:first_name => params[:first_name],
		:last_name => params[:last_name],
		:email => params[:email],
		:note => params[:note]
		)
	redirect to('/contacts')
end

post "/search" do
	attribute = params[:attribute]
	@contacts_to_search = Contact.all.select { |contact| contact.first_name == attribute || contact.last_name == attribute || contact.email == attribute || contact.note == attribute }
	params[:page_name] = "Search Result"
	if @contacts_to_search
		erb :search_contact
	else
		erb :not_found
	end
end


