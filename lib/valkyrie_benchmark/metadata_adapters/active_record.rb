module ValkyrieBenchmark
  module MetadataAdapters
    module ActiveRecord
      extend ActiveSupport::Concern

      def run_migrations(migrations_paths, options = {})
        establish_connection

        begin
          verbose = options.fetch(:verbose, true)
          version = options[:version]
          scope   = options[:scope]

          verbose_was = ::ActiveRecord::Migration.verbose
          ::ActiveRecord::Migration.verbose = verbose
          if ::ActiveRecord::Migrator.respond_to?(:migrate)
            # ActiveRecord < 5.2.0
            ::ActiveRecord::Migrator.migrate(migrations_paths, version) do |migration|
              scope.blank? || scope == migration.scope
            end
          else
            # ActiveRecord >= 5.2.0
            ::ActiveRecord::MigrationContext.new(migrations_paths).migrate(version) do |migration|
              scope.blank? || scope == migration.scope
            end
          end
          ::ActiveRecord::Base.clear_cache!
        ensure
          ::ActiveRecord::Migration.verbose = verbose_was
        end
      end
      
      def establish_connection
        ::ActiveRecord::Base.connection_pool.disconnect! if ::ActiveRecord::Base.connected?
        ::ActiveRecord::Base.establish_connection(config['db'])
      end

      def migrations_path
        File.join(Dir.pwd,'db','migrate','activerecord')
      end
      
      def migrate
        run_migrations([migrations_path])
      end

    end
  end
end