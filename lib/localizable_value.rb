require "localizable_value/version"

module LocalizableValue
  # Your code goes here...
end

require 'localizable_value/engine'
require "localizable_value/railtie"
require "localizable_value/app/uploaders/localizable_image_uploader"
require "localizable_value/app/models/localized_page"
require "localizable_value/app/models/localized_value"
require "localizable_value/app/models/localized_image"
require "localizable_value/app/models/localized_group"
# require "localizable_value/app/controllers/localized_values_controller"
require "localizable_value/config/routes"
