Rails.application.routes.draw do
  namespace :localizable_value do
    resources :localized_values
  end
end