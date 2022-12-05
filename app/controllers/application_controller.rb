class ApplicationController < ActionController::API
  include Pagy::Backend
  include Authentication
  include ErrorHandler

  # Override page size param name
  def pagy_get_vars(collection, vars)
    vars = super
    vars[:items] = params[:size] || Pagy::DEFAULT[:items]
    vars
  end

  def render_json(data, options = {})
    if data.respond_to?(:each)
      page, records = pagy(data)
      json = { data: records }.merge(page_meta(page))
    else
      json = data
    end
    render json: json, **options
  end

  private

  def page_meta(page)
    {
      count: page.count,
      page: page.page,
      total_pages: page.pages
    }
  end
end
