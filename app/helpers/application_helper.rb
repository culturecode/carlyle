module ApplicationHelper
  def datestamp(date)
    date.strftime("%b %e, %Y")
  end

  def record_list(records, namespace: nil, delimiter: ', ')
    Array.wrap(records).collect do |record|
      link_to record.to_s, [namespace, record].compact
    end.join(delimiter).html_safe.presence
  end
end
