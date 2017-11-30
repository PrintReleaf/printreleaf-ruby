module PrintReleaf
  class Feed < Resource
    path "/feeds"

    action :find
    action :list
    action :create
    action :update
    action :delete
    action :activate
    action :deactivate

    property :id
    property :account_id
    property :type
    property :server_id
    property :external_id
    property :collection_scope
    property :created_at, transform_with: Transforms::Date
    property :status
    property :activated_at, transform_with: Transforms::Date
    property :deactivated_at, transform_with: Transforms::Date
    property :health_check
    property :health_check_checked_at, transform_with: Transforms::Date
    property :health_check_changed_at, transform_with: Transforms::Date

    def account
      @account ||= Account.find(account_id)
    end

    def server
      return nil if server_id.nil?
      @server ||= Server.find(server_id)
    end
  end
end

