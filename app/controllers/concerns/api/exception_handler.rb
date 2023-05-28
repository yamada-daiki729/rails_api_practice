module Api::ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :render_internal_server_error
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  end

  private

  def render_bad_request(exception = nil, messages = nil)
    render_error(400, 'Bad Request', exception&.message, *messages)
  end

  def render_not_found(exception = nil, messages = nil)
    render_error(404, 'Record Not Found', exception&.message, *messages)
  end

  def render_internal_server_error(exception = nil, messages = nil)
    render_error(500, 'Internal Server Error', exception&.message, *messages)
  end

  def render_error(code, message, *error_messages)
    response = {
      message: message,
      errors: error_messages.compact
    }

    render json: response, status: code
  end
end
