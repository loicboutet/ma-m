class RatingsController < ApplicationController
  before_action :set_rating, only: [:show, :edit, :update, :destroy]

  # GET /ratings
  # GET /ratings.json
  def index
    @ratings = Rating.all
  end

  # GET /ratings/1
  # GET /ratings/1.json
  def show
  end

  # GET /ratings/new
  def new
    @rating = Rating.new
    @shop_id = params['shop_id']
    @like = params['like']
  end

  # GET /ratings/1/edit
  def edit
  end

  # POST /ratings
  # POST /ratings.json
  def create
    @comment = Comment.create(
                                comment: params['comment']['text'],
                                regular: (params['regular'] == 'regular'),
                                user: current_user,
                                shop: Shop.find(params['shop_id']),
                                date: DateTime.now,
                              )
    stars = (params['rating']['quality'].to_i + params['rating']['service'].to_i + params['rating']['price'].to_i) / 3
    @rating = Rating.create(
                              quality: params['rating']['quality'],
                              service: params['rating']['service'],
                              price: params['rating']['price'],
                              stars: stars,
                              user: current_user,
                              shop: Shop.find(params['shop_id']),
                              like: params['like'],
                            )
    redirect_to "/shops/#{params['shop_id']}"
  end

  # PATCH/PUT /ratings/1
  # PATCH/PUT /ratings/1.json
  def update
    respond_to do |format|
      if @rating.update(rating_params)
        format.html { redirect_to @rating, notice: 'Rating was successfully updated.' }
        format.json { render :show, status: :ok, location: @rating }
      else
        format.html { render :edit }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ratings/1
  # DELETE /ratings/1.json
  def destroy
    @rating.destroy
    respond_to do |format|
      format.html { redirect_to ratings_url, notice: 'Rating was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rating_params
      params[:rating]
    end
end
