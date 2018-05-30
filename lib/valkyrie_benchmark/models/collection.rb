module ValkyrieBenchmark
  module Models
    class Collection < Valkyrie::Resource
      attribute :id, Valkyrie::Types::ID.optional
      attribute :alternate_ids, Valkyrie::Types::Array.of(Valkyrie::Types::ID)
      attribute :title, Valkyrie::Types::Array
      attribute :description, Valkyrie::Types::Array
      attribute :member_ids, Valkyrie::Types::Array.of(Valkyrie::Types::ID)
      attribute :representative_id, Valkyrie::Types::ID.optional
    end
  end
end