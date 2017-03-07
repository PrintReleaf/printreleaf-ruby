module PrintReleaf
  module Paper
    class Type < Resource
      path "/paper/types"

      action :find
      action :list
      action :create
      action :delete

      property :id
      property :account_id
      property :name
      property :density, transform_with: Transforms::Float

      def account
        return nil if account_id.nil?
        @account ||= Account.find(account_id)
      end
    end
  end
end

