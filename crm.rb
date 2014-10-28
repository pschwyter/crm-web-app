require 'sinatra'

get "/" do
	@crm_app_name = "Bitmaker CRM"
	erb :index
end

