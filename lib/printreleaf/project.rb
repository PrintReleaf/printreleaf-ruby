module PrintReleaf
  class Project < Resource
    path "/projects"

    action :find
    action :list

    property :id
    property :name
    property :status
    property :forest_latitude
    property :forest_longitude
    property :content_logo
    property :content_masthead
    property :content_introduction
    property :content_body_html
    property :content_images

    def active?
      status == "active"
    end

    def inactive?
      status == "inactive"
    end
  end
end

