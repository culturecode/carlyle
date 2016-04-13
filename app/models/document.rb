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

  def public_file_name
    if self['name']
      "#{self['name']} - #{date.strftime('%Y-%m-%e')}#{File.extname(self['attachment'])}"
    else
      self['attachment']
    end
  end
end
