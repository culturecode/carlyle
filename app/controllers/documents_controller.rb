class DocumentsController < ApplicationController
  http_basic_authenticate_with :name => ENV['OWNER_USERNAME'], :password => ENV['OWNER_PASSWORD']

  def index
    @minutes = Document.minutes.order('date DESC')
    @rules = Document.rules.order('date DESC')
    @bylaws = Document.bylaws.order('date DESC')
    @notices = Document.notice.order('date DESC')
    @forms = Document.form.order('date DESC')
  end
end
