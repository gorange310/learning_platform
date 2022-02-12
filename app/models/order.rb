class Order < ApplicationRecord
  belongs_to :user_program
  belongs_to :currency

  delegate :user, to: :user_program
  delegate :program, to: :user_program
end
