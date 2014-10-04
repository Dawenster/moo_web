Rails.application.routes.draw do
  post "/create_record" => "apis#create_record", :as => :create_record
end
