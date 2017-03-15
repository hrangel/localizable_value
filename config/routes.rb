Rails.application.routes.draw do
  namespace :localizable_value do
    resources :localized_values
    resources :localized_images
  end
end