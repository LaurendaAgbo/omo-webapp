class AbusesController < ApplicationController

  layout 'abuses'

  before_action :authenticate_admin!, only: %i[index new show]

  def index
    @abuses = Abuse.all
  end

  def new
    @abuse = Abuse.new
  end

  def create
  end

  def update
  end

  def destroy
  end

  def show
    @abuse = Abuse.find(params[:id])
  end

  def edit
  end

  private

  def abuse_params
    params.require(:abuse).permit(:description, :address, :contact)
  end
end
