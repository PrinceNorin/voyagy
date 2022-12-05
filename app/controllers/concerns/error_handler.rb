module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :handle_error

    private

    def handle_error(ex)
      case ex
      when ActiveRecord::RecordInvalid
        render_bad_request(ex)
      when ActiveRecord::RecordNotFound
        render_not_found(ex)
      else
        render_server_error(ex)
      end
    end

    def render_bad_request(ex)
      render json: {
        code: 400,
        error: '400 Bad request',
        details: ex.record.errors.as_json
      }, status: :bad_request
    end

    def render_not_found(ex)
      render json: {
        code: 404,
        error: '404 Not found'
      }, status: :not_found
    end

    def render_server_error(ex)
      # TODO: send to error tracking service like sentry
      logger.error(ex.backtrace)
      render json: {
        code: 500,
        error: '500 Internal server error'
      }, status: :internal_server_error
    end
  end
end
