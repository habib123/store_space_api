class Api::V1::SpacesController < Api::V1::BaseController
  before_action :set_space, only: [:destroy, :update, :show, :price]

  def index
    @spaces =  Space.all
  end

  def create
    respond_with :api, :v1, Space.create!(space_params)
  end

  def show
  end

  def destroy
    respond_with @space.destroy
  end

  def update
    @space.update_attributes!(space_params)
    respond_with @space, json: @space
  end

  def price
    begin
      start_date = Date.strptime(params[:start_date], "%d-%m-%Y")
      end_date = Date.strptime(params[:end_date], "%d-%m-%Y")
      if Space.end_date_is_after_start_date(start_date, end_date)
         render json: {status: "error", message: "Can't blank or end date less then start date" }
      else
        @price = @space.total_price(start_date, end_date)
        render json: { price: @price }
      end
    rescue ArgumentError
      render json: { status: "ArgumentError" }
    end
  end

  private

  def space_params
    params.require(:space).permit(:store, :title, :size, :price_per_day, :price_per_week, :price_per_month)
  end

  def set_space
    @space =  Space.find(params[:id])
  end
end
