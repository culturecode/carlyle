module Admin
  class DocumentsController < AdminController
    respond_to :html

    def index
      @documents = Document.order('id DESC')
    end

    def new
      @document = Document.new
    end

    def create
      @document = Document.create(document_params)
      respond_with(:admin, @document, :location => [:admin, :documents])
    end

    def edit
      @document = Document.find(params[:id])
    end

    def update
      @document = Document.find(params[:id])
      @document.update_attributes(document_params)
      respond_with(:admin, @document, :location => [:admin, :documents])
    end


    def destroy
      Document.find(params[:id]).destroy
      redirect_to [:admin, :documents], :notice => 'Document deleted'
    end

    private

    def document_params
      params.require(:document).permit(:attachment, :document_type, :name, :description)
    end
  end
end

