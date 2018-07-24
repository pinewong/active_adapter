module ActiveAdapter
  class Abstract
    attr_reader :adapter

    def initialize(implement_adapter_class)
      @adapter = implement_adapter_class.new
    end
  end
end
