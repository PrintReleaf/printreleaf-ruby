module PrintReleaf
  class Source < Resource
    path "/sources"

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
    property :created_at, transform_with: Transforms::Date
    property :credentials
    coerce_key :credentials, ->(hash) { Config.new(hash) }
    property :status
    property :activated_at, transform_with: Transforms::Date
    property :deactivated_at, transform_with: Transforms::Date
    property :health_check
    property :health_check_updated_at, transform_with: Transforms::Date

    def account
      @account ||= Account.find(account_id)
    end

    class Config < Hashie::Mash
    end
  end
end

