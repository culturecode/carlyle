class Document < ActiveRecord::Base
  mount_uploader :attachment, AttachmentUploader

  class_attribute :valid_types
  self.valid_types = %w(Notice Bylaws Rules Form Minutes)

  valid_types.each do |type|
    scope type.downcase, lambda { where(:document_type => type) }
  end

  validates_presence_of :attachment, :document_type

  def name
    self['name'].presence || self['attachment']
  end
end
