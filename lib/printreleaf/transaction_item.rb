module PrintReleaf
  class TransactionItem < Resource
    property :pages, transform_with: Transforms::Integer
    property :width, transform_with: Transforms::Float
    property :height, transform_with: Transforms::Float
    property :density, transform_with: Transforms::Float
    property :paper_type_id
  end
end

