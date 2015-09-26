class Shop < ActiveRecord::Base
  # Associations

  has_many :ratings

  # -- Associations

  # Methods

  def average_stars
    self.ratings.pluck(:stars).sum / self.ratings.count
  end

  def dislikes
    self.ratings.where(like: false)
  end

  def likes
    self.ratings.where(like: true)
  end

  # -- Methods
end
