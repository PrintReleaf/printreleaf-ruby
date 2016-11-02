module PrintReleaf
  class Invitation < Resource
    path "/invitations"

    action :find
    action :list
    action :create
    action :delete

    property :id
    property :account_id
    property :email
    property :created_at, transform_with: Transforms::Date

    def account
      @account ||= Account.find(account_id)
    end
  end
end

