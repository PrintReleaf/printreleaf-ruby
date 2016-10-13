module PrintReleaf
  class Integration < Resource
    include Actions::Find
    include Actions::List

    property :id
    property :name
    property :description

    def self.uri
      "/integrations"
    end
  end
end

