require "spec_helper"
require "fakes/some_module/vehicle"
require "fakes/some_module/vehicle_adapters/abstract"
require "fakes/some_module/vehicle_adapters/bus"
require "fakes/some_module/vehicle_adapters/car"
require "fakes/some_module/other"

RSpec.describe ActiveAdapter do
  let(:bus) { SomeModule::Vehicle.adapt(:bus) }
  let(:car) { SomeModule::Vehicle.adapt(:car) }

  it "impl by adapter" do
    expect(bus.run).to eq("Bus running...")
    expect(car.run).to eq("Car running...")
  end

  it "raise ArgumentError" do
    expect { bus.wrong_args_impl("arg1", "arg2", "arg3") }.to raise_error(ArgumentError)
  end

  it "raise ActiveAdapter::MethodNotImplementError" do
    expect { bus.no_impl }.to raise_error(ActiveAdapter::MethodNotImplementError)
  end

  it "raise ActiveAdapter::ImplementAdapterUndefinedError" do
    expect { SomeModule::Vehicle.adapt(:undefined) }.to raise_error(ActiveAdapter::ImplementAdapterUndefinedError)
  end

  it "raise ActiveAdapter::AbstractAdapterUndefinedError" do
    expect { SomeModule::Other.adapt(:impl) }.to raise_error(ActiveAdapter::AbstractAdapterUndefinedError)
  end
end
