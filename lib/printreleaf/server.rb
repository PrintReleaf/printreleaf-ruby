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
    property :credentials
    coerce_key :credentials, ->(hash) { Config.new(hash) }

    def account
      @account ||= Account.find(account_id)
    end

    class Config < Hashie::Mash
    end
  end
end

