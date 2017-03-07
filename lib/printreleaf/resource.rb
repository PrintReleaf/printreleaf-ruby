module PrintReleaf
  class Resource < Hashie::Trash
    include Hashie::Extensions::IndifferentAccess
    include Hashie::Extensions::IgnoreUndeclared
    include Hashie::Extensions::Coercion

    class << self
      def path(value=nil)
        @path = value if value
        @path or raise "Path not declared."
      end

      def uri
        path
      end

      def actions
        @actions ||= Set.new
      end

      def action(sym)
        actions.tap { |list|
          list.add(sym)
        }.each { |action|
          include Actions.const_get(action.to_s.capitalize)
        }
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

    def find(*args)
      raise DoesNotImplement, "Resource does not implement `find`"
    end

    def delete
      raise DoesNotImplement, "Resource does not implement `delete`"
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

    def to_s
      "#<#{self.class.name}>"
    end

    def inspect
      "".tap do |str|
        str << "#<#{self.class} "
        str << JSON.pretty_generate(self)
        str << ">"
      end
    end

    def compact_inspect
      "".tap do |str|
        str << "#<#{self.class} "
        str << "id='#{self.id}'" if respond_to?(:id)
        str << ">"
      end
    end
  end
end

