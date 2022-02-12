class Order < ApplicationRecord
  belongs_to :user
  belongs_to :program
  belongs_to :currency
end
