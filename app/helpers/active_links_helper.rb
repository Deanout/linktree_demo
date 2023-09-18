# frozen_string_literal: true

module ActiveLinksHelper
  def active_link_to(text = nil, path = nil, **options, &)
    link = block_given? ? text : path

    options[:class] = class_names(options[:class], 'active') if current_page?(link)

    if block_given?
      link_to(text, options, &)
    else
      link_to(text, path, options)
    end
  end
end
