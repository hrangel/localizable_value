module LocalizableValueHelper
  def localized_value_string(page, key, default_value)
    render partial: 'localizable_value/string', :locals => { localized_page: page, key: key, default_value: default_value }
  end

  def localized_value_text(page, key, default_value)
    render partial: 'localizable_value/text', :locals => { localized_page: page, key: key, default_value: default_value }
  end

  def localized_value_string_read(page, key, default_value)
    render partial: 'localizable_value/string_read', :locals => { localized_page: page, key: key, default_value: default_value }
  end

  def localized_value_element(page, key, default_value, label)
    render layout: 'localizable_value/element', :locals => { localized_page: page, key: key, default_value: default_value, label: label } do |locals|
      yield locals
    end
  end

  def localized_value_link(page, key, default_value, link)
    render partial: 'localizable_value/link', :locals => { localized_page: page, key: key, default_value: default_value, link: link }
  end

  def localized_value_link_attr(page, key, default_value, attrs)
    render partial: 'localizable_value/link_attr', :locals => { localized_page: page, key: key, default_value: default_value, attrs: attrs }
  end

  def content_tag(*args)
    if block_given?
      tag = Tag.new(args[0], args[1] || {})
      old_buf = @output_buffer
      @output_buffer = ActionView::OutputBuffer.new
      value = yield(tag)
      content = tag.render(@output_buffer.presence || value)
      @output_buffer = old_buf
      content
    else
      super
    end
  end

  class Tag
    include ActionView::Helpers::CaptureHelper
    attr_accessor :id
    attr_reader :name, :css

    def initialize(name, attributes = {})
      @name = name
      @attributes = attributes.with_indifferent_access
      @attributes[:class] = Tag::CSS.new(attributes[:class])
    end

    def []=(k,v)
      @attributes[k] = v
    end
    
    def [](k)
      @attributes[k]
    end
    
    def render(content)
      "<#{name}#{render_attributes}>#{content.strip}</#{name}>".html_safe
    end

    def render_attributes
      attrs = @attributes.dup
      if self[:class].empty?
        attrs.delete :class
      else
        attrs[:class] = self[:class].to_s
      end

      attrs.keys.map do |k|
        "#{k}='#{ERB::Util.html_escape(attrs[k])}'".html_safe
      end.join(' ').prepend(' ')
    end

    class CSS
      
      def initialize(css)
        if css.is_a? String
          @internals = css.split(' ')
        else
          @internals = css.to_a
        end
      end

      def to_s
        @internals.uniq.join(' ')
      end

      def empty?
        @internals.empty?
      end

      def <<(name)
        @internals << name
        nil
      end
    end
  end
end