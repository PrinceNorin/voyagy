class Api::V1::VoyagesController < ApplicationController
  before_action :find_vessel

  def index
    render_json @vessel.voyages, status: :ok
  end

  def create
    voyage = @vessel.voyages.create!(voyage_params)
    render_json voyage, status: :created
  end

  def update
    voyage = @vessel.voyages.find(params[:id])
    voyage.update!(voyage_params)
    render_json voyage, status: :ok
  end

  private

  def find_vessel
    @vessel = current_user.vessels.find(params[:vessel_id])
  end

  def voyage_params
    params.permit(
      :from_loc, :to_loc,
      :departured_at,
      :arrived_at
    )
  end
end
