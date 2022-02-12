class UserProgram < ApplicationRecord
  belongs_to :user
  belongs_to :program

  def is_valid?(date=Date.today)
    self.expired_date >= date
  end

  def is_invalid?(date=Date.today)
    !self.is_valid?
  end
end
