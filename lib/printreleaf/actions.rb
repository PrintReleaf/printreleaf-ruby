module PrintReleaf
  module Actions
    module Find
      def self.included(base)
        base.extend(ClassMethods)
        base.include(InstanceMethods)
      end

      def self.extended(base)
        base.extend(InstanceMethods)
      end

      module ClassMethods
        def find(id)
          uri = Util.join_uri(self.uri, id)
          response = PrintReleaf.get(uri)
          self.new(response)
        end
      end

      module InstanceMethods
        def reload
          response = PrintReleaf.get(self.uri)
          self.reset(response)
        end
      end
    end

    module List
      def self.included(base)
        base.extend(ClassMethods)
        base.include(InstanceMethods)
      end

      def self.extended(base)
        base.extend(InstanceMethods)
      end

      module ClassMethods
        def list(params={})
          PrintReleaf.get(self.uri, params).map do |response|
            self.new(response)
          end
        end

        def first
          list.first
        end

        def last
          list.last
        end

        def count
          list.count
        end

        def length
          list.length
        end
      end

      module InstanceMethods
        def list(params={})
          PrintReleaf.get(self.uri, params).map do |response|
            self.new(response)
          end
        end
      end
    end

    module Create
      def self.included(base)
        base.extend(self)
      end

      def create(params)
        response = PrintReleaf.post(self.uri, params)
        self.new(response)
      end
    end

    module Update
      def save
        if self.id.nil?
          response = PrintReleaf.post(self.uri, self.to_hash)
        else
          response = PrintReleaf.patch(self.uri, changes)
        end
        reset(response)
        return true
      end
    end

    module Delete
      def delete
        response = PrintReleaf.delete(self.uri)
        reset(response)
        return true
      end
    end

    module Activate
      def activate
        uri = Util.join_uri(self.uri, "activate")
        response = PrintReleaf.post(uri)
        reset(response)
        return true
      end
    end

    module Deactivate
      def deactivate
        uri = Util.join_uri(self.uri, "deactivate")
        response = PrintReleaf.post(uri)
        reset(response)
        return true
      end
    end
  end
end

