Rails.application.routes.draw do
  get "/fetch_records" => "apis#fetch_records", :as => :fetch_records
  post "/create_record" => "apis#create_record", :as => :create_record
  get "/get_username" => "apis#get_username", :as => :get_username
  post "/update_username" => "apis#update_username", :as => :update_username
end
