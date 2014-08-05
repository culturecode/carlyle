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
      document_cry(@document, 'uploaded') unless @document.new_record?
    end

    def edit
      @document = Document.find(params[:id])
    end

    def update
      @document = Document.find(params[:id])
      @document.update_attributes(document_params)
      respond_with(:admin, @document, :location => [:admin, :documents])
      document_cry(@document, 'edited the metadata about') unless @document.changed?
    end

    def destroy
      Document.find(params[:id]).destroy
      redirect_to [:admin, :documents], :notice => 'Document deleted'
      document_cry(@document, 'deleted')
    end

    private

    def document_params
      params.require(:document).permit(:attachment, :document_type, :name, :description, :date)
    end

    def document_cry(document, action)
      cry("#{current_user} #{action} a #{document.document_type.singularize.downcase}, \"#{document.name}\"", :subject => document)
    end
  end
end

