module PrintReleaf
  class Certificate < Resource
    path "/certificates"

    action :find
    action :list

    property :id
    property :account_id
    property :period_start, transform_with: Transforms::Date
    property :period_end, transform_with: Transforms::Date
    property :pages, transform_with: Transforms::Integer
    property :trees, transform_with: Transforms::Float
    property :project_id
    property :project
    coerce_key :project, Project

    def account
      @account ||= Account.find(account_id)
    end
  end
end

