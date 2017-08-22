module PrintReleaf
  class Server < Resource
    path "/servers"

    action :find
    action :list
    action :create
    action :update
    action :delete

    property :id
    property :account_id
    property :type
    property :created_at, transform_with: Transforms::Date
    property :url
    property :username
    property :password
    property :contact

    def account
      @account ||= Account.find(account_id)
    end
  end
end

