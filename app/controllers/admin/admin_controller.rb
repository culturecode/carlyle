module Admin
  class AdminController < ApplicationController
    http_basic_authenticate_with :name => ENV['ADMIN_USERNAME'], :password => ENV['ADMIN_USERNAME']
  end
end
