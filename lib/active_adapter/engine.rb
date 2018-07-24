module ActiveAdapter
  class Engine
    class << self
      def adapters
        @adapters ||= {}
      end

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
