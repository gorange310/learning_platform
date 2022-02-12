module ApiV0
  module Entities
    class Order < Entities::Base
      expose :id
      expose :program, with: ApiV0::Entities::Program
      expose :status
      expose :amount
      expose :currency, with: ApiV0::Entities::Currency
      expose :date, format_with: :iso8601
    end
  end
end
