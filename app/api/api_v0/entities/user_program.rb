module ApiV0
  module Entities
    class UserProgram < Entities::Base
      expose :id
      expose :program, with: ApiV0::Entities::Program
      expose :status
      expose :amount
      expose :currency, format_with: :name
      expose :date, format_with: :iso8601
    end
  end
end
