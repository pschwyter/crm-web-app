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
	property :group, String

end

DataMapper.finalize
DataMapper.auto_upgrade!

get "/" do
	@crm_app_name = "Bitmaker CRM"
	params[:page_name] = "Contacts / <a href=/contacts/new><span class='glyph-add-icon glyphicon glyphicon-plus'></span></a>"
	@contacts = Contact.all
	erb :contacts
end

get "/contacts" do
	params[:page_name] = "Contacts / <a href=/contacts/new><span class='glyph-add-icon glyphicon glyphicon-plus'></span></a>"
	@contacts = Contact.all
	erb :contacts
end

get "/contacts/new" do
	params[:page_name] = "<a href='/contacts'>Contacts</a> / New Contact"
	erb :new_contact
end

get "/contacts/:group" do
	group = params[:group]
	@contacts_by_group = Contact.all.select { |contact| contact.group == group }
	params[:page_name] = "<a href='/contacts'>Contacts</a> / #{group}"
	puts @contacts_by_group
	erb :contacts_group
end

get "/contacts/view/:id" do
	id = params[:id].to_i
	@contact_to_view = Contact.get(id)
	params[:page_name] = "<a href='/contacts'>Contacts</a> / <a href='/contacts/#{@contact_to_view.group}'>#{@contact_to_view.group}</a> / #{@contact_to_view.first_name} #{@contact_to_view.last_name}"
	if @contact_to_view
		erb :view_contacts
	else
		erb :not_found
	end
end

delete "/contacts/delete/:id" do
	id = params[:id].to_i
	contact_to_delete = Contact.get(id)
	if contact_to_delete
		contact_to_delete.destroy
		redirect to('/contacts')
	else
		erb :not_found
	end
end

put "/contacts/:id/edit" do
	id = params[:id].to_i
	contact_to_edit = Contact.get(id)
	contact_to_edit.update(:first_name => params[:first_name],
		:last_name => params[:last_name],
		:email => params[:email],
		:note => params[:note],
		:group => params[:group]
		)
	redirect to('/contacts')
end

post "/contacts" do
	contact = Contact.create(
		:first_name => params[:first_name],
		:last_name => params[:last_name],
		:email => params[:email],
		:note => params[:note],
		:group => params[:group]
	)
	redirect to('/contacts')
end


post "/search" do
	attribute = params[:attribute]
	@contacts_to_search = Contact.all.select { |contact| contact.group == attribute || contact.first_name == attribute || contact.last_name == attribute || contact.email == attribute || contact.note == attribute }
	params[:page_name] = "<a href='/contacts'>Contacts</a> / #{attribute}"
	if @contacts_to_search
		erb :search_contact
	else
		erb :not_found
	end
end


