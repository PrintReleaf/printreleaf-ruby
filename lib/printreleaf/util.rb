module PrintReleaf
  module Util
    extend self

    def join_uri(*args)
      Array(args).join("/").gsub(/\/{2,}/, "/").chomp("/")
    end
  end
end

