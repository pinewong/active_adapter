module ActiveAdapter
  class Engine
    class << self
      def adapters
        @adapters ||= {}
      end

      # To adapt engine object for a real object
      # @param adapter [#to_sym] Adapter class name
      # @return [Object] The real object with a adapter
      # @raise [ActiveAdapter::AbstractAdapterUndefinedError] if there is no *_adapters folder or
      #   there is no abstract class(inherit from ActiveAdapter::Abstract) in *_adapters folder
      # @raise [ActiveAdapter::ImplementAdapterUndefinedError] if there is no implement class
      #   inherit from ActiveAdapter::Implement)
      # @example
      #   # vehicle.rb
      #   class Vehicle < ActiveAdapter::Engine; end
      #
      #   # vehicle_adapters/abstract.rb
      #   class VehicleAdapters::Abstract < ActiveAdapter::Abstract
      #     def run
      #       adapter.run
      #     end
      #   end
      #
      #   # vehicle_adapters/car.rb
      #   class VehicleAdapters::Car < ActiveAdapter::Implement
      #     def run
      #       "Car running..."
      #     end
      #   end
      #
      #   vehicle = Vehicle.adapt(:car)
      #   vehicle.run # => "Car running..."
      def adapt(adapter)
        adapters[adapter.to_s] ||= begin
          module_name = "#{name.deconstantize}::#{name.demodulize}Adapters"
          abstract_adapter_class = get_abstract_adapter_class(module_name)
          implement_adapter_class = get_implement_adapter_class(module_name, adapter)
          implement_adapter_class.abstract_adapter = abstract_adapter_class
          abstract_adapter_class.new(implement_adapter_class)
        end
      end

      private

      def get_implement_adapter_class(module_name, adapter)
        "#{module_name}::#{adapter.to_s.camelize}".constantize
      rescue NameError => e
        raise ActiveAdapter::ImplementAdapterUndefinedError, e
      end

      def get_abstract_adapter_class(module_name)
        "#{module_name}::Abstract".constantize
      rescue NameError => e
        raise ActiveAdapter::AbstractAdapterUndefinedError, e
      end
    end
  end
end
