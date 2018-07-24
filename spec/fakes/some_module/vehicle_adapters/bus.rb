module SomeModule
  module VehicleAdapters
    class Bus < ActiveAdapter::Implement
      def run
        "Bus running..."
      end

      def wrong_args_impl(arg1, arg2); end
    end
  end
end
