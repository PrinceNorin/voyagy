class Api::V1::VesselsController < ApplicationController
  def index
    render_json current_user.vessels, status: :ok
  end

  def create
    vessel = current_user.vessels.create!(vessel_params)
    render_json vessel, status: :created
  end

  def update
    vessel = current_user.vessels.find(params[:id])
    vessel.update!(vessel_params)
    render_json vessel, status: :ok
  end

  private

  def vessel_params
    params.permit(:name, :owner_id, :naccs)
  end
end
