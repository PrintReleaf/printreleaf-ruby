module PrintReleaf
  class VolumePeriod < Resource
    property :account_id
    property :date,  transform_with: Transforms::Date
    property :pages, transform_with: Transforms::Integer
    property :trees, transform_with: Transforms::Float

    def account
      @account ||= Account.find(account_id)
    end
  end
end

