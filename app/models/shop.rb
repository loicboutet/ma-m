class Shop < ActiveRecord::Base
  # AlgoliaSearch

  include AlgoliaSearch

  algoliasearch do
    attribute :title, :phone, :address, :job, :email, :site, :facebook, :twitter
    geoloc :lat, :lng
  end

  # -- AlgoliaSearch

  # Associations

  has_many :comments
  has_many :ratings

  # -- Associations

  # Callbacks

  after_create :algolia_create

  # -- Callbacks

  # Methods

  def algolia_create
    self.index!
  end

  def average_stars
    (self.ratings.pluck(:stars).sum.to_f / self.ratings.count / 2).round(1)
  end

  def dislikes
    self.ratings.where(like: false).count
  end

  def job_rating
    data = Hash.new

    Shop.where(job: self.job).each do |shop|
      data[shop] = (shop.average_stars.nan?) ? 0 : shop.average_stars
    end

    data.sort_by{ |k, v| v }.each_with_index do |shop, index|
      shop = shop.first
      return "#{data.count - index} sur #{data.count}" if shop == self
    end
  end

  def likes
    self.ratings.where(like: true).count
  end

  # -- Methods

  # Uploader

  mount_uploader :profile_image, ImageUploader

  # -- Uploader
end
