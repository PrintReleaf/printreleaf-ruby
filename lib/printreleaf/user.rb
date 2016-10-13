module PrintReleaf
  class User < Resource
    path "/users"

    property :id
    property :account_id
    property :name
    property :email
    property :created_at, transform_with: Transforms::Date

    def account
      @account ||= Account.find(account_id)
    end
  end
end

