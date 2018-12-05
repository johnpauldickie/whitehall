module PublishingApi
  module PayloadBuilder
    class BrexitDetails
      def self.for(item)
        has_brexit_update = item.has_brexit_update

        return {} if has_brexit_update.nil?

        { has_brexit_update: has_brexit_update }
      end
    end
  end
end
