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

  def localized_string(localized_page, key, default)
    localized_page.get_value(key, default)
  end

  def localized_image(localized_page, key, default)
    localized_page.get_value(key, default, LocalizableValue::LocalizedImage.name)
  end
end