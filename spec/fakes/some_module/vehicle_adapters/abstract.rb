module SomeModule
  module VehicleAdapters
    class Abstract < ActiveAdapter::Abstract
      def run
        adapter.run
      end

      def no_impl
        adapter.no_impl
      end

      def wrong_args_impl(arg1, arg2, arg3)
        adapter.wrong_args_impl(arg1, arg2, arg3)
      end
    end
  end
end
