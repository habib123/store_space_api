class Api::V1::StoresController < Api::V1::BaseController
  before_action :set_store, only: [:destroy, :update, :show]

  def index
    @stores = Store.filter(params)
  end

  def create
    respond_with :api, Store.create!(store_params)
  end

  def show
  end

  def destroy
    respond_with @store.destroy
  end

  def update
    @store.update_attributes!(store_params)
    respond_with @store, json: @store
  end

  private

  def store_params
    params.require(:store).permit(:title, :city, :street, :spaces_count)
  end

  def set_store
    @store =  Store.find(params[:id])
  end
end
