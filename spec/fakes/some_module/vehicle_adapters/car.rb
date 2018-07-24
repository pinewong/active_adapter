module SomeModule
  module VehicleAdapters
    class Car < ActiveAdapter::Implement
      def run
        "Car running..."
      end
    end
  end
end
