LocalizableValue::Engine.routes do
  namespace :localizable_value do
    resources :localized_values, only: [:update]
  end
end