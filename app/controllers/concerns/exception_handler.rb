module ExceptionHandler
  extend ActiveSupport::Concern
  
  def not_acceptable(error_message)
    if !error_message.is_a?(String) && error_message.respond_to?(:errors)
      error_message = error_message.errors.messages.values.flatten
    end
    render json: { error: error_message }, status: :not_acceptable
    false
  end

  def record_not_found(error_message)
    render json: { error: error_message }, status: :not_found
    false
  end
end