class IslandsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_island, only: %i[show]

  def index
    @islands = Island.all
  end

  def show
  end

  def new
    @island = Island.new
  end

  def create
    @island = Island.new(island_params)
    @island.user = current_user # Associates the current user to the island that gets created! This user is the OWNER
    if @island.save
      redirect_to island_path(@island)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_island
    @island = Island.find(params[:id])
  end

  def island_params
    params.require(:island).permit(:title, :description, :address, :price_per_night)
  end
end