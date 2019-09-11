module PrintReleaf
  class Quote < Resource
    path "/quotes"

    action :find
    action :list
    action :create
    action :delete

    property :id
    property :account_id
    property :project_id
    property :transaction_id
    property :created_at,     transform_with: Transforms::Date
    property :standard_pages, transform_with: Transforms::Integer
    property :trees,          transform_with: Transforms::Float
    property :rate,      transform_with: Transforms::Float
    property :price,     transform_with: Transforms::Float
    property :items
    coerce_key :items, Array[QuoteItem]

    def account
      @account ||= Account.find(account_id)
    end

    def transaction
      return nil if transaction_id.nil?
      @transaction ||= Transaction.find(transaction_id)
    end
  end
end

