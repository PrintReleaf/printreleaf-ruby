module PrintReleaf
  module Actions
    module Find
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def find(id)
          new PrintReleaf.get Util.join_uri(self.uri, id)
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
            new response
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
          new PrintReleaf.post self.uri, params
        end
      end
    end

    module Update
      def save
        PrintReleaf.patch self.uri, changes
        true
      end
    end

    module Delete
      def delete
        PrintReleaf.delete self.uri
        true
      end
    end
  end
end

