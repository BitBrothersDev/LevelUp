class ApplicationController < ActionController::Base
  # include Pagy::Backend
  http_basic_authenticate_with :name => "password", :password => "password"
end
