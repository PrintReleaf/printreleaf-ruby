module PrintReleaf
  class Resource < Hashie::Trash
    include Hashie::Extensions::IndifferentAccess
    include Hashie::Extensions::IgnoreUndeclared
    include Hashie::Extensions::Coercion

    class << self
      def path(value=nil)
        @path = value if value
        @path or raise "path not declared"
      end

      def uri
        path
      end

      def action(sym)
        mod = Actions.const_get(sym.to_s.capitalize)
        include mod
      end
    end

    attr_reader :copy

    def initialize(*args)
      super
      @copy = self.dup.freeze
    end

    def uri
      Util.join_uri(self.class.uri, self.id)
    end

    def find
      raise "Does not implement"
    end

    def changes
      keys.map(&:to_sym).inject({}) do |diff, key|
        unless self[key] == copy[key]
          diff[key] = self[key]
        end
        diff
      end
    end

  end
end

