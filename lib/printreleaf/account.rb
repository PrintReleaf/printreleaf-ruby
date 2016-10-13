module PrintReleaf
  class Account < Resource
    path "/accounts"

    action :find
    action :list
    action :create
    action :update
    action :delete
    action :activate
    action :deactivate

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

    def active?
      status == "active"
    end

    def inactive?
      status == "inactive"
    end

    def parent
      @parent ||= Account.find(parent_id)
    end

    def activities
      uri = Util.join_uri(self.uri, "activities")
      PrintReleaf.get(uri).map do |response|
        Activity.new(response)
      end
    end

    def volume
      uri = Util.join_uri(self.uri, "volume")
      PrintReleaf.get(uri).map do |response|
        VolumePeriod.new(response)
      end
    end
  end
end

