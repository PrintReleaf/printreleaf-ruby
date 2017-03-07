module PrintReleaf
  class Relation
    include Enumerable

    attr_reader :owner
    attr_reader :resource_class
    attr_reader :path
    attr_reader :actions

    def initialize(owner, resource_class, options={})
      @owner          = owner
      @resource_class = resource_class
      @path           = options[:path] || resource_class.uri
      @actions        = Set.new(options[:actions] || resource_class.actions)
      @actions.each do |action|
        extend Actions.const_get(action.to_s.capitalize)
      end
    end

    def uri
      Util.join_uri(owner.uri, path)
    end

    def new(*args)
      @resource_class.new(*args).tap do |resource|
        resource.owner = owner
      end
    end

    def related
      if respond_to?(:list)
        return list
      else
        raise "Relation not defined."
      end
    end

    def each
      return enum_for(:each) unless block_given?
      related.each do |resource|
        yield resource
      end
    end

    def first
      related.first
    end

    def last
      related.last
    end

    def count
      related.count
    end

    def length
      related.length
    end

    def to_s
      "#<#{self.class.name}(#{resource_class}>"
    end

    def inspect
      "#<#{self.class}(#{resource_class}) owner=#{owner.compact_inspect} path=#{path} actions=#{actions}>"
    end
  end
end

