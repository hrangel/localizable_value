module LocalizableValue
  class LocalizedValuesController < ApplicationController
    respond_to :html, :json

    skip_before_action :verify_authenticity_token
    before_action :check_can_edit
    before_action :require_value

    def update
      @localized_value.update(localized_value_params)
      @localized_value.localized_page.reset_cache if @localized_value.localized_page
      after_localizable_value_changed(@localized_value) if respond_to?(:after_localizable_value_changed)
      respond_with(@localized_value)
    end

    private
      def check_can_edit
        return head(:unauthorized) if !@can_edit
      end

      def require_value
        @localized_value = LocalizedValue.find(params[:id])
      end

      def localized_value_params
        params.require(:localizable_value_localized_value).permit(:value)
      end
  end
end