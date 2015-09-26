class ShopsController < ApplicationController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]

  # GET /shops
  # GET /shops.json
  def index
    shop_ids = Array.new
    algolia_result = Shop.raw_search(params['query'], aroundLatLng: "#{params['lat']},#{params['lng']}", aroundRadius: 5000)
    shop_ids += algolia_result['hits'].map { |hit| hit['objectID'] }
    while algolia_result['page'] + 1 < algolia_result['nbPages']
      algolia_result = Shop.raw_search(params['query'], page: algolia_result['page'] + 1, aroundLatLng: "#{params['lat']},#{params['lng']}", aroundRadius: 5000)
      shop_ids += algolia_result['hits'].map { |hit| hit['objectID'] }
    end
    @shops = Shop.where(id: shop_ids)
    respond_to do |format|
      format.json{render json: @shops}
      format.html
    end
  end

  # GET /shops/1
  # GET /shops/1.json
  def show
    @stars = ['empty', 'empty', 'empty', 'empty', 'empty']
    @stars[0] = 'half' if @shop.average_rating(:stars) >= 0.5
    @stars[0] = 'full' if @shop.average_rating(:stars) >= 1
    @stars[1] = 'half' if @shop.average_rating(:stars) >= 1.5
    @stars[1] = 'full' if @shop.average_rating(:stars) >= 2
    @stars[2] = 'half' if @shop.average_rating(:stars) >= 2.5
    @stars[2] = 'full' if @shop.average_rating(:stars) >= 3
    @stars[3] = 'half' if @shop.average_rating(:stars) >= 3.5
    @stars[3] = 'full' if @shop.average_rating(:stars) >= 4
    @stars[4] = 'half' if @shop.average_rating(:stars) >= 4.5
    @stars[4] = 'full' if @shop.average_rating(:stars) >= 5

    @quality = ['empty', 'empty', 'empty', 'empty', 'empty']
    @quality[0] = 'half' if @shop.average_rating(:quality) >= 0.5
    @quality[0] = 'full' if @shop.average_rating(:quality) >= 1
    @quality[1] = 'half' if @shop.average_rating(:quality) >= 1.5
    @quality[1] = 'full' if @shop.average_rating(:quality) >= 2
    @quality[2] = 'half' if @shop.average_rating(:quality) >= 2.5
    @quality[2] = 'full' if @shop.average_rating(:quality) >= 3
    @quality[3] = 'half' if @shop.average_rating(:quality) >= 3.5
    @quality[3] = 'full' if @shop.average_rating(:quality) >= 4
    @quality[4] = 'half' if @shop.average_rating(:quality) >= 4.5
    @quality[4] = 'full' if @shop.average_rating(:quality) >= 5

    @services = ['empty', 'empty', 'empty', 'empty', 'empty']
    @services[0] = 'half' if @shop.average_rating(:service) >= 0.5
    @services[0] = 'full' if @shop.average_rating(:service) >= 1
    @services[1] = 'half' if @shop.average_rating(:service) >= 1.5
    @services[1] = 'full' if @shop.average_rating(:service) >= 2
    @services[2] = 'half' if @shop.average_rating(:service) >= 2.5
    @services[2] = 'full' if @shop.average_rating(:service) >= 3
    @services[3] = 'half' if @shop.average_rating(:service) >= 3.5
    @services[3] = 'full' if @shop.average_rating(:service) >= 4
    @services[4] = 'half' if @shop.average_rating(:service) >= 4.5
    @services[4] = 'full' if @shop.average_rating(:service) >= 5

    @price = ['empty', 'empty', 'empty', 'empty', 'empty']
    @price[0] = 'half' if @shop.average_rating(:price) >= 0.5
    @price[0] = 'full' if @shop.average_rating(:price) >= 1
    @price[1] = 'half' if @shop.average_rating(:price) >= 1.5
    @price[1] = 'full' if @shop.average_rating(:price) >= 2
    @price[2] = 'half' if @shop.average_rating(:price) >= 2.5
    @price[2] = 'full' if @shop.average_rating(:price) >= 3
    @price[3] = 'half' if @shop.average_rating(:price) >= 3.5
    @price[3] = 'full' if @shop.average_rating(:price) >= 4
    @price[4] = 'half' if @shop.average_rating(:price) >= 4.5
    @price[4] = 'full' if @shop.average_rating(:price) >= 5
    @job_rating = @shop.job_rating
  end

  # GET /shops/new
  def new
    @shop = Shop.new
  end

  # GET /shops/1/edit
  def edit
  end

  # POST /shops
  # POST /shops.json
  def create
    @shop = Shop.new(shop_params)

    respond_to do |format|
      if @shop.save
        format.html { redirect_to @shop, notice: 'Shop was successfully created.' }
        format.json { render :show, status: :created, location: @shop }
      else
        format.html { render :new }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shops/1
  # PATCH/PUT /shops/1.json
  def update
    respond_to do |format|
      if @shop.update(shop_params)
        format.html { redirect_to @shop, notice: 'Shop was successfully updated.' }
        format.json { render :show, status: :ok, location: @shop }
      else
        format.html { render :edit }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shops/1
  # DELETE /shops/1.json
  def destroy
    @shop.destroy
    respond_to do |format|
      format.html { redirect_to shops_url, notice: 'Shop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop
      @shop = Shop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_params
      params[:shop]
    end
end
