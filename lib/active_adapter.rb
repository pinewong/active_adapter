require "active_adapter/version"
require "active_support/all"

module ActiveAdapter
  extend ActiveSupport::Autoload

  autoload :Engine
  autoload :Abstract
  autoload :Implement

  eager_autoload do
    autoload :Error, "active_adapter/errors"
    autoload :AbstractAdapterUndefinedError, "active_adapter/errors"
    autoload :ImplementAdapterUndefinedError, "active_adapter/errors"
    autoload :MethodNotImplementError, "active_adapter/errors"
  end
end
