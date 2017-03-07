module PrintReleaf
  class TransactionItem < Resource
    property :pages, transform_with: Transforms::Integer
    property :width, transform_with: Transforms::Float
    property :height, transform_with: Transforms::Float
    property :density, transform_with: Transforms::Float
    property :paper_type_id

    def paper_type
      return nil if paper_type_id.nil?
      @paper_type ||= Paper::Type.find(paper_type_id)
    end
  end
end

