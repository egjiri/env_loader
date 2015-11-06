module ConfiguratorGem
  class Railtie < Rails::Railtie
    rake_tasks do
      rake_files = Dir[File.join(File.dirname(__FILE__), '..', 'tasks', '*.rake')]
      rake_files.each { |rake_file| load rake_file }
    end
  end
end
