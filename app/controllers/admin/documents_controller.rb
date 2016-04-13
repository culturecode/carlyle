require 'open-uri'

module Admin
  class DocumentsController < AdminController
    load_and_authorize_resource

    respond_to :html

    def index
      @documents = Document.order('date DESC')
    end

    def new
      @document = Document.new
    end

    def create
      @document = Document.create(document_params)
      respond_with(:admin, @document, :location => [:admin, :documents])
    end

    def show
      send_file open(@document.attachment.url), :filename => @document.public_file_name, :disposition => :inline
    end

    def edit; end

    def update
      @document.update_attributes(document_params)
      respond_with(:admin, @document, :location => [:admin, :documents])
    end

    def destroy
      @document.destroy
      redirect_to [:admin, :documents], :notice => 'Document deleted'
    end

    private

    def document_params
      params.require(:document).permit(:attachment, :document_type, :name, :description, :date)
    end
  end
end
