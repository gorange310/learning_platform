module ApiV0
  module Entities
    class Order < Entities::Base
      expose :id
      expose :program, format_with: :name
      expose :status
      expose :amount
      expose :currency, format_with: :name
      expose :date, format_with: :iso8601
    end
  end
end
