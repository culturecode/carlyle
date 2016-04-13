require 'open-uri'

module Owner
  class DocumentsController < ApplicationController
    load_and_authorize_resource

    rescue_from CanCan::AccessDenied, :with => :allow_owner_login

    def index
      @minutes = Document.minutes.order('date DESC')
      @rules = Document.rules.order('date DESC')
      @bylaws = Document.bylaws.order('date DESC')
      @notices = Document.notice.order('date DESC')
      @forms = Document.form.order('date DESC')
    end

    def show
      send_file open(@document.attachment.url), :filename => @document.public_file_name
    end
  end
end
