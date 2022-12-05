class Api::V1::VesselsController < ApplicationController
  def index
    page, vessels = pagy(current_user.vessels)
    data = { data: vessels }.merge(page_meta(page))
    render json: data, status: :ok
  end

  def create
    vessel = current_user.vessels.create!(vessel_params)
    render json: { data: vessel }, status: :created
  end

  def update
    vessel = current_user.vessels.find(params[:id])
    vessel.update!(vessel_params)
    render json: { data: vessel }, status: :ok
  end

  private

  def vessel_params
    params.permit(:name, :owner_id, :naccs)
  end
end
