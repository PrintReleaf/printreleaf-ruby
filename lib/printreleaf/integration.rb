module PrintReleaf
  class Integration < Resource
    path "/integrations"

    action :find
    action :list

    property :id
    property :name
    property :description
  end
end

