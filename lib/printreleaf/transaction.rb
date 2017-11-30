module PrintReleaf
  class Transaction < Resource
    path "/transactions"

    action :find
    action :list
    action :create
    action :delete

    property :id
    property :account_id
    property :project_id
    property :certificate_id
    property :quote_id
    property :date, transform_with: Transforms::Date
    property :pages, transform_with: Transforms::Integer
    property :trees, transform_with: Transforms::Float

    def account
      @account ||= Account.find(account_id)
    end

    def project
      @project ||= Forestry::Project.find(project_id)
    end

    def certificate
      @certificate ||= Certificate.find(certificate_id)
    end

    def quote
      return nil if quote_id.nil?
      @quote ||= Quote.find(quote_id)
    end
  end
end

