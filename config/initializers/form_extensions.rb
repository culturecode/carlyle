module FormExtensions
  def cancel(path = options[:url])
    @template.link_to 'Cancel', path, :class => 'btn'
  end
end

ActionView::Helpers::FormBuilder.send(:include, FormExtensions)
