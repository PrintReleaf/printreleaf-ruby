module PrintReleaf
  module Actions
    module Find
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def find(id)
          uri = Util.join_uri(self.uri, id)
          response = PrintReleaf.get(uri)
          self.new(response)
        end
      end
    end

    module List
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def list(params={})
          PrintReleaf.get(self.uri, params).map do |response|
            self.new(response)
          end
        end
      end
    end

    module Create
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def create(params)
          response = PrintReleaf.post(self.uri, params)
          self.new(response)
        end
      end
    end

    module Update
      def save
        response = PrintReleaf.patch(self.uri, changes)
        self.update(response)
        return true
      end
    end

    module Delete
      def delete
        response = PrintReleaf.delete(self.uri)
        self.update(response)
        return true
      end
    end

    module Activate
      def activate
        uri = Util.join_uri(self.uri, "activate")
        response = PrintReleaf.post(uri)
        self.update(response)
        return true
      end
    end

    module Deactivate
      def deactivate
        uri = Util.join_uri(self.uri, "deactivate")
        response = PrintReleaf.post(uri)
        self.update(response)
        return true
      end
    end
  end
end

