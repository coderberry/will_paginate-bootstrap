# encoding: utf-8

require "bootstrap_pagination/version"

module BootstrapPagination
  # Contains functionality shared by all renderer classes.
  module LinkRenderer
    ELLIPSIS = '…'

    def to_html
      list_items = pagination.map do |item|
        case item
          when Fixnum
            page_number(item)
          else
            send(item)
        end
      end

      html_container(tag('ul', list_items.join(@options[:link_separator])))
    end

    protected

    def page_number(page)
      unless page == current_page
        tag('li', link(page, page, :rel => rel_value(page)))
      else
        tag('li', link(page, page), :class => 'active')
      end
    end

    def gap
      tag('li', link(ELLIPSIS, '#'), :class => 'disabled')
    end

    def previous_page
      num = @collection.current_page > 1 && @collection.current_page - 1
      previous_or_next_page(num, @options[:previous_label], 'prev')
    end

    def next_page
      num = @collection.current_page < @collection.total_pages && @collection.current_page + 1
      previous_or_next_page(num, @options[:next_label], 'next')
    end

    def previous_or_next_page(page, text, classname)
      if page
        tag('li', link(text, page), :class => classname)
      else
        tag('li', link(text, '#'), :class => "%s disabled" % classname)
      end
    end
  end
end