module ValkyrieBenchmark
  module MetadataAdapters
    class ActiveRecordPostgres < ValkyrieActiveRecord
    end
  end
end

ValkyrieBenchmark::MetadataAdapters.register_metadata_adapter(ValkyrieBenchmark::MetadataAdapters::ActiveRecordPostgres)
