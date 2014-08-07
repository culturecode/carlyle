class DocumentObserver < CrierObserver
  def after_create(document)
    document_cry(document, 'uploaded')
  end

  def after_update(document)
    document_cry(document, 'metadata edited')
  end

  def after_destroy(document)
    document_cry(document, 'deleted')
  end

  def document_cry(document, action)
    current_user.cry("#{document.document_type.singularize.titleize} #{action} \"#{document.name}\"", :subject => document)
  end
end
