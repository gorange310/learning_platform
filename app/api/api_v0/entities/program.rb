module ApiV0
  module Entities
    class Program < Entities::Base
      expose :name
      expose :category, with: ApiV0::Entities::ProgramCategory
      expose :type, with: ApiV0::Entities::ProgramType
      expose :url
      expose :description
    end
  end
end
