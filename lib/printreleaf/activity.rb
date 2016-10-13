module PrintReleaf
  class Activity < Resource
    property :id
    property :account_id
    property :date, transform_with: Transforms::Date
    property :type
    property :description

    def account
      @account ||= Account.find(account_id)
    end
  end
end

