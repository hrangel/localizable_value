# == Schema Information
#
# Table name: localized_values
#
#  id                :integer          not null, primary key
#  localized_page_id :integer
#  key               :string
#  value             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  type              :string
#

require 'carrierwave'
require 'carrierwave/orm/activerecord'

module LocalizableValue
  class LocalizedImage < LocalizableValue::LocalizedValue
    mount_uploader :value, LocalizableImageUploader
  end
end