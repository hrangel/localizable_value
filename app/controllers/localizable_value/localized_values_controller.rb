module LocalizableValue
  class LocalizedValueController < ApplicationController
    respond_to :html, :json

    skip_before_action :verify_authenticity_token
    before_action :check_can_edit
    before_action :require_value

    def update
      @localized_value.update(localized_value_params)
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
        if params.key? :localized_image
          params.require(:localized_image).permit(:value)
        else
          params.require(:localized_value).permit(:value)
        end
      end
  end
end