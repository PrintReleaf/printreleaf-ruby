module PrintReleaf
  class Account < Resource
    path "/accounts"

    action :find
    action :list
    action :create
    action :update
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

    def self.mine
      response = PrintReleaf.get("/account")
      self.new(response)
    end

    # Account URI is always root, even when it has an owner.
    #   /accounts/456
    # Instead of:
    #   /accounts/123/accounts/456
    def uri
      Util.join_uri(self.class.uri, self.id)
    end

    def active?
      status == "active"
    end

    def inactive?
      status == "inactive"
    end

    def parent
      @parent ||= Account.find(parent_id)
    end

    def children
      accounts
    end

    def accounts
      @accounts ||= Relation.new(self, Account)
    end

    def certificates
      @certificates ||= Relation.new(self, Certificate)
    end

    def invitations
      @invitations ||= Relation.new(self, Invitation)
    end

    def servers
      @servers ||= Relation.new(self, Server)
    end

    def sources
      @sources ||= Relation.new(self, Source)
    end

    def users
      @users ||= Relation.new(self, User)
    end

    def volume
      @volume ||= Relation.new(self, VolumePeriod)
    end
  end
end

