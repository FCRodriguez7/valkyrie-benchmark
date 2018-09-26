module ValkyrieBenchmark
  module Models
    class Page < Valkyrie::Resource
      attribute :title, Valkyrie::Types::Array
      attribute :text, Valkyrie::Types::Array
    end
  end
end