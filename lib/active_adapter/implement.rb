module ActiveAdapter
  class Implement
    class << self
      attr_accessor :abstract_adapter
    end

    delegate :abstract_adapter, to: :class

    def method_missing(method, *_args)
      # 抽象适配器定义的方法，适配器未实现，则提示未实现异常
      super unless abstract_adapter.public_instance_methods.include?(method)
      raise ActiveAdapter::MethodNotImplementError, "#{method} - #{self.class.name}"
    end

    def respond_to_missing?(method, include_private = false)
      super
    end
  end
end
