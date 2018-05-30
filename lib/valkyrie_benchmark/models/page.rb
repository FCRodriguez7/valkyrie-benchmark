module ValkyrieBenchmark
  module Models
    class Page < Valkyrie::Resource
      attribute :id, Valkyrie::Types::ID.optional
      attribute :title, Valkyrie::Types::Array
      attribute :text, Valkyrie::Types::Array
    end
  end
end