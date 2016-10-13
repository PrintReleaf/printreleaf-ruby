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

    # Default properties
    property :deleted

    attr_reader :copy
    attr_accessor :owner

    def initialize(*args)
      super
      @copy = self.dup.freeze
    end

    def uri
      scope = owner ? owner.uri : nil
      Util.join_uri(scope, self.class.uri, self.id)
    end

    def find
      raise "Does not implement"
    end

    def reset(hash)
      delete_if { true }
      update(hash)
    end

    def changes
      keys.map(&:to_sym).inject({}) do |diff, key|
        unless self[key] == copy[key]
          diff[key] = self[key]
        end
        diff
      end
    end

    def deleted?
      !!deleted
    end
  end
end

