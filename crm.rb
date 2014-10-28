require 'sinatra'
require './contacts'

get "/" do
	@crm_app_name = "Bitmaker CRM"
	erb :index
end

get "/contacts" do
	erb :contacts
end

get "/contacts/new" do
	erb :contacts_new
end