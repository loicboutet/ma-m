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


  def stars
    stars = ['empty', 'empty', 'empty', 'empty', 'empty']
    stars[0] = 'half' if self.average_stars >= 0.5
    stars[0] = 'full' if self.average_stars >= 1
    stars[1] = 'half' if self.average_stars >= 1.5
    stars[1] = 'full' if self.average_stars >= 2
    stars[2] = 'half' if self.average_stars >= 2.5
    stars[2] = 'full' if self.average_stars >= 3
    stars[3] = 'half' if self.average_stars >= 3.5
    stars[3] = 'full' if self.average_stars >= 4
    stars[4] = 'half' if self.average_stars >= 4.5
    stars[4] = 'full' if self.average_stars >= 5
    return stars
  end
  # -- Methods

  # Uploader

  mount_uploader :profile_image, ImageUploader

  # -- Uploader
end
