module ValkyrieBenchmark
  module MetadataAdapters
    class ActiveRecordSqlite < ValkyrieActiveRecord
    end
  end
end

ValkyrieBenchmark::MetadataAdapters.register_metadata_adapter(ValkyrieBenchmark::MetadataAdapters::ActiveRecordSqlite)
