module ValkyrieBenchmark
  module Models
    class Book < Valkyrie::Resource
      attribute :id, Valkyrie::Types::ID.optional
      attribute :alternate_ids, Valkyrie::Types::Array.of(Valkyrie::Types::ID)
      attribute :title, Valkyrie::Types::Array
      attribute :date, Valkyrie::Types::Array
      attribute :publisher, Valkyrie::Types::Array
      attribute :keywords, Valkyrie::Types::Array
      attribute :isbn, Valkyrie::Types::Array
      attribute :language, Valkyrie::Types::Array
      attribute :format, Valkyrie::Types::Array
      attribute :online_copy, Valkyrie::Types::Array
      attribute :note, Valkyrie::Types::Array
      attribute :author_ids, Valkyrie::Types::Array.of(Valkyrie::Types::ID)      
      attribute :member_ids, Valkyrie::Types::Array.of(Valkyrie::Types::ID)
      attribute :representative_id, Valkyrie::Types::ID.optional
    end
  end
end