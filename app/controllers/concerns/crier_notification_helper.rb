require 'active_support/concern'

module CrierNotificationHelper
  extend ActiveSupport::Concern

  def cry(message, options = {})
    options.reverse_merge! :action => params[:action], :scope => self.class.name.demodulize.underscore
    current_user.cry(message, options)
  end

  # When an attribute or association changes, use this to create notifications for the changed record
  def diff_cry(subject, action, is)
    cry("#{subject} now #{action} #{is}", :subject => subject, :action => action, :value => is)
  end

  # When an association association changes, use this to create notifications for all the associated records
  def association_diff_cry(is, action, object, was)
    is = Array.wrap(is)
    was = Array.wrap(was)
    (is - was).each do |subject|
      cry("#{subject} now #{action} #{object}", :subject => subject, :action => action, :object => object)
    end
    (was - is).each do |subject|
      cry("#{subject} no longer #{action} #{object}", :subject => subject, :action => "no longer #{action}", :object => object)
    end
  end
end
