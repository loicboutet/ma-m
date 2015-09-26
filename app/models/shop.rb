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

  def likes
    self.ratings.where(like: true).count
  end

  # -- Methods

  # Uploader

  mount_uploader :profile_image, ImageUploader

  # -- Uploader
end
