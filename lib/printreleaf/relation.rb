module PrintReleaf
  class Relation
    include Enumerable
    extend Forwardable
    def_delegators :resources, :each, :first, :last, :size, :count, :length

    attr_reader :owner
    attr_reader :resource_class
    attr_reader :path
    attr_reader :actions

    def initialize(owner, resource_class, options={})
      @owner          = owner
      @resource_class = resource_class
      @path           = options[:path] || resource_class.uri

      actions = options[:actions] || [:list, :find]
      actions.each do |action|
        mod = Actions.const_get(action.to_s.capitalize)
        extend mod
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

    def resources
      list
    end
  end
end

