module ValkyrieBenchmark
  module MetadataAdapters
    class ActiveRecordMysql < ValkyrieActiveRecord
    end
  end
end

ValkyrieBenchmark::MetadataAdapters.register_metadata_adapter(ValkyrieBenchmark::MetadataAdapters::ActiveRecordMysql)
