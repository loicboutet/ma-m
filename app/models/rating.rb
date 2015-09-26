class Rating < ActiveRecord::Base
  # Associations

  belongs_to :shop
  belongs_to :user

  # -- Associations

  # Callbacks

  before_save   :update_stars

  # -- Callbacks

  # Methods

  def update_stars
    self.stars = (self.quality + self.price + self.service) / 3
    self.save!
  end

  # -- Methods

  # Validations

  validates :like, :inclusion => {:in => [true, false]}
  validates :stars, numericality:   {
                                      greater_than_or_equal: 0,
                                      less_than_or_equal_to: 10,
                                    }
  validates :service, numericality:   {
                                        greater_than_or_equal: 0,
                                        less_than_or_equal_to: 10,
                                      }
  validates :quality, numericality:   {
                                        greater_than_or_equal: 0,
                                        less_than_or_equal_to: 10,
                                      }
  validates :price, numericality:   {
                                      greater_than_or_equal: 0,
                                      less_than_or_equal_to: 10,
                                    }
  validates :shop, presence: true
  validates :user, presence: true

  # -- Validations
end
