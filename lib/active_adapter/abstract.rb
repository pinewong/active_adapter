module ActiveAdapter
  class Abstract
    attr_reader :adapter

    # Instance an real object from abstract object by adapter
    # @param implement_adapter_class [Class] The implement adapter class
    def initialize(implement_adapter_class)
      @adapter = implement_adapter_class.new
    end
  end
end
