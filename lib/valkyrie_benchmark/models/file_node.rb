module ValkyrieBenchmark
  module Models
    class FileNode < Valkyrie::Resource
      attribute :title, Valkyrie::Types::Array
      attribute :mime_type, Valkyrie::Types::Array
      attribute :checksum, Valkyrie::Types::Array
      attribute :size, Valkyrie::Types::Array
      attribute :original_filename, Valkyrie::Types::Array
      attribute :file_identifiers, Valkyrie::Types::Array
    end
  end
end