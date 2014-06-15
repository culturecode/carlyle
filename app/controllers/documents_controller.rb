class DocumentsController < ApplicationController
  http_basic_authenticate_with :name => ENV['OWNER_USERNAME'], :password => ENV['OWNER_PASSWORD']

  def index
    @minutes = Document.minutes
    @rules = Document.rules
    @bylaws = Document.bylaws
    @notices = Document.notice
    @forms = Document.form
  end
end
