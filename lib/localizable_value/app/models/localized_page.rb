# == Schema Information
#
# Table name: localized_pages
#
#  id         :integer          not null, primary key
#  locale     :string
#  page_uid   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

module LocalizableValue
  class LocalizedPage < ActiveRecord::Base
    has_many :localized_values, dependent: :destroy

    def self.global_page
      @@global_page ||= LocalizedPage.by_locale(I18n.locale.to_s.downcase, 'GLOBAL')
    end

    def self.current_page(controller_name, action_name)
      LocalizedPage.by_locale(I18n.locale.to_s.downcase, controller_name + '#' + action_name)
    end

    def self.by_locale(locale, page_uid)
      LocalizedPage.find_or_create_by(locale: locale.to_s.downcase, page_uid: page_uid)
    end

    def get_value(key, default_value, type = nil)
      value = localized_values.select { |v| v.key == key && v.type == type }.first
      value = localized_values.create(localized_page: self, key: key, type: type, value: default_value) if !value
      value
    end

    def insert_grouped_values(prefix_key, values)
      new_order = get_last_grouped_value_order(prefix_key) + 1
      values.each do |property, text| 
        key = "%s_%04d_%s" % [prefix_key, new_order, property.to_s]
        get_value(key, text)
      end
    end

    def get_last_grouped_value_order(prefix_key)
      values = localized_values.where(localized_page: self).where('key like ?', prefix_key + '_%' ).order('key DESC')
      return values.first ? values.first.get_grouped_value_order(prefix_key) : 0
    end

    def get_grouped_value_list(prefix_key, main_property = 'title')
      values = localized_values.where(localized_page: self).where('key like ? and key like ?', prefix_key + '_%', '%_' + main_property.to_s).order('key ASC')
      group = values.map { |item| 
        group = LocalizedGroup.new
        group.page = self
        group.prefix_key = prefix_key + '_' + item.get_grouped_value_order_key(prefix_key)
        group
      }
    end
  end
end