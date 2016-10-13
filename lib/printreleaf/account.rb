module PrintReleaf
  class Account < Resource
    path "/accounts"

    action :find
    action :list
    action :create
    action :update
    action :delete

    property :id
    property :name
    property :role
    property :parent_id
    property :status
    property :created_at,     transform_with: Transforms::Date
    property :activated_at,   transform_with: Transforms::Date
    property :deactivated_at, transform_with: Transforms::Date
    property :accounts_count, transform_with: Transforms::Integer
    property :users_count,    transform_with: Transforms::Integer
    property :mtd_pages,      transform_with: Transforms::Integer
    property :qtd_pages,      transform_with: Transforms::Integer
    property :ytd_pages,      transform_with: Transforms::Integer
    property :lifetime_pages, transform_with: Transforms::Integer
    property :mtd_trees,      transform_with: Transforms::Float
    property :qtd_trees,      transform_with: Transforms::Float
    property :ytd_trees,      transform_with: Transforms::Float
    property :lifetime_trees, transform_with: Transforms::Float

    def activate
      response = PrintReleaf.post(self.uri + "/activate")
      self.update(response)
      return true
    end

    def deactivate
      response = PrintReleaf.post(self.uri + "/deactivate")
      self.update(response)
      return true
    end

    def parent
      Account.find(parent_id)
    end
  end
end

