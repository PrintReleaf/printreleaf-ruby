module PrintReleaf
  module Transforms
    Integer = lambda { |v| v.to_i }
    Float   = lambda { |v| v.to_f }
    Date    = lambda { |v| v.nil? ? nil : DateTime.parse(v) }
  end
end

