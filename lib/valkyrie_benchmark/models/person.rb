module ValkyrieBenchmark
  module Models
    class Person < Valkyrie::Resource
      attribute :alternate_ids, Valkyrie::Types::Array.of(Valkyrie::Types::ID)
      attribute :firstname, Valkyrie::Types::Array
      attribute :lastname, Valkyrie::Types::Array
      attribute :affiliation, Valkyrie::Types::Array
    end
  end
end