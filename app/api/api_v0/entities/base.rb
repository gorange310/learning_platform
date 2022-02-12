module ApiV0
  module Entities
    class Base < Grape::Entity
      format_with(:iso8601) { |dt| dt.iso8601 }
      format_with(:name) { |dt| dt.name }
    end
  end
end
