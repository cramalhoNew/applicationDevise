# frozen_string_literal: true

if Rails.env.development?
  namespace :db do
    desc "Drops, creates, migrates and seeds data. ** POSTGRESQL dependent**"
    task rebuild: :environment do
      puts "** REVOKING ALL CLIENTS ACCESS TO THE DATABASE **"
      psql = ActiveRecord::Base.connection
      [
          Rails.configuration.database_configuration["development"]["database"],
          Rails.configuration.database_configuration["test"]["database"]
      ].each do |database|
        psql.execute("REVOKE CONNECT ON DATABASE #{database} FROM public;")
      end
      psql.execute("SELECT pg_terminate_backend(pid) FROM pg_stat_activity where pid <> pg_backend_pid();")

      puts "Deleting public assets ..."
      puts Rails.root.join("public", "system")
      FileUtils.rm_rf(Rails.root.join("public", "system"))

      puts "Dropping database ..."
      Rake::Task["db:drop"].invoke

      puts "Creating database ..."
      Rake::Task["db:create"].invoke

      puts "Migrating ..."
      Rake::Task["db:migrate"].invoke

      puts "Seeding ..."
      Rake::Task["db:seed"].invoke
    end
  end
end
