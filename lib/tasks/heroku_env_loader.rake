require 'uiux'

namespace :env_loader do
  desc 'Sets the Heroku config variables based on the EnvLoader'
  task :set_heroku_configs, [:heroku_app, :config_file, :config_subtree_key] => [:environment] do |_t, args|
    UI.start 'Setting Heroku config variables based on the EnvLoader...' do
      [:heroku_app, :config_file, :config_subtree_key].each do |arg|
        UI.error "Missing \"#{arg}\" argument!" if args[arg].blank?
      end

      UI.heading 'Desired Heroku configs:'
      ap config = EnvLoader::Configurator.new(
        config_file: args[:config_file],
        config_subtree_key: args[:config_subtree_key]
      ).config

      UI.heading 'Current Heroku configs:'
      result = UI.execute "heroku config -a #{args[:heroku_app]}"
      heroku_config_hash = {}
      result.split("\n").each do |row|
        parsed_row = YAML.load(row)
        heroku_config_hash.merge!(parsed_row) if parsed_row.is_a?(Hash)
      end

      UI.heading 'Updating Heroku configs...'
      config.each do |key, value|
        if heroku_config_hash[key].to_s == value
          UI.message "Config already set: #{key}=#{value}"
        else
          value = "\"#{value}\"" unless %w(true false).include?(value.to_s)
          UI.execute "heroku config:add #{key}=#{value} -a #{args[:heroku_app]}"
        end
      end

      UI.heading 'Updated Heroku configs:'
      UI.execute "heroku config -a #{args[:heroku_app]}"
    end
  end
end
