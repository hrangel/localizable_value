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

module LocalizableValue
  class LocalizedImage < LocalizedValue
    mount_uploader :value, RegularUploader
  end
end