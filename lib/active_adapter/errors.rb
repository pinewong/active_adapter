module ActiveAdapter
  class Error < StandardError; end

  class AbstractAdapterUndefinedError < Error; end

  class ImplementAdapterUndefinedError < Error; end

  class MethodNotImplementError < Error; end
end
