class ApplicationController < ActionController::API
  include Pagy::Backend

  REALM = 'Bearer'

  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordInvalid, with: :render_bad_request

  def current_user
    @current_user ||= _current_user
  end

  # Override page size param name
  def pagy_get_vars(collection, vars)
    vars = super
    vars[:items] = params[:size] || Pagy::DEFAULT[:items]
    vars
  end

  protected

  def authenticate_user!
    unless current_user
      render json: {
        code: 401,
        error: '401 Unauthorized'
      }, status: :unauthorized
    end
  end

  def render_bad_request(ex)
    render json: {
      code: 400,
      error: '400 Bad request',
      details: ex.record.errors.as_json
    }, status: :bad_request
  end

  def page_meta(page)
    {
      count: page.count,
      page: page.page,
      total_pages: page.pages
    }
  end

  private

  def token
    header = request.headers[:authorization]
    if header
      realm, jwt = header.split(' ')
      return jwt if realm == REALM
    else
      params[:token].to_s
    end
  end

  def _current_user
    return unless token
    begin
      payload = TokenService.decode(token)
      User.find_by(id: payload[:user_id])
    rescue TokenService::InvalidToken
      nil
    end
  end
end
