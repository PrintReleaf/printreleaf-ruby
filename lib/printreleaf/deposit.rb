module PrintReleaf
  class Deposit < Resource
    path "/deposits"

    action :find
    action :list
    action :create
    action :delete

    property :id
    property :account_id
    property :source_id
    property :date
    property :pages
    property :width
    property :height
    property :density
    property :paper_type_id

    def account
      @account ||= Account.find(account_id)
    end

    def source
      return nil if source_id.nil?
      @source ||= Source.find(source_id)
    end

    def paper_type
      return nil if paper_type_id.nil?
      @paper_type ||= Paper::Type.find(paper_type_id)
    end
  end
end

