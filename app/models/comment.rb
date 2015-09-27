class Comment < ActiveRecord::Base
  # Associations

  belongs_to  :user
  belongs_to  :shop

  # -- Associations

  # Methods

  def date
    self[:date].strftime("%d/%m/%Y - %H:%M:%S")
  end

  # -- Methods
end
