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
    redirect_to Document.find(params[:id]).attachment.url
  end
end
