class Rating < ActiveRecord::Base
  # Associations

  belongs_to :shop
  belongs_to :user

  # -- Associations

  # Validations

  validates :like, :inclusion => {:in => [true, false]}
  validates :stars, numericality:   {
                                      greater_than_or_equal: 0,
                                      less_than_or_equal_to: 10,
                                    }
  validates :shop, presence: true
  validates :user, presence: true

  # -- Validations
end
