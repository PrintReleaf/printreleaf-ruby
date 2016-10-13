require 'spec_helper'

describe PrintReleaf::Transforms::Integer do
  let(:transform) { PrintReleaf::Transforms::Integer }
  it "transforms the value to an integer" do
    expect(transform.call(123)).to eq 123
    expect(transform.call(123.456)).to eq 123
    expect(transform.call("123")).to eq 123
    expect(transform.call("123.456")).to eq 123
  end
end

describe PrintReleaf::Transforms::Float do
  let(:transform) { PrintReleaf::Transforms::Float }
  it "transforms the value to a float" do
    expect(transform.call(123.456)).to eq 123.456
    expect(transform.call(123)).to eq 123.0
    expect(transform.call("123")).to eq 123.0
    expect(transform.call("123.456")).to eq 123.456
  end
end

describe PrintReleaf::Transforms::Date do
  let(:transform) { PrintReleaf::Transforms::Date }
  it "transforms the value to a date" do
    str = "2014-10-13T02:55:29Z"
    date = DateTime.parse(str)
    expect(transform.call(str)).to eq date
  end

  it "returns nil when the date is nil" do
    expect(transform.call(nil)).to eq nil
  end
end

