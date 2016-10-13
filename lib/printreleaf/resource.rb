module PrintReleaf
  class Resource < Hashie::Trash
    include Hashie::Extensions::IndifferentAccess
    include Hashie::Extensions::IgnoreUndeclared
    include Hashie::Extensions::Coercion

    class << self
      def path(value=nil)
        @path = value if value
        @path
      end

      def uri
        path
      end

      def action(sym)
        mod = Actions.const_get(sym.to_s.capitalize)
        include mod
      end
    end

    def initialize(*args)
      super
      @_old = self.dup
    end

    def uri
      Util.join_uri(self.class.uri, self.id)
    end

    def changes
      keys.inject({}) do |diff, key|
        unless self[key] == @_old[key]
          diff[key] = self[key]
        end
        diff
      end
    end
  end
end

