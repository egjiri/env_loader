require 'env_loader/version'
require 'yaml'

module EnvLoader

  def self.read(env_yml_file)
    if File.exists? env_yml_file
      if hash = YAML.load(File.open env_yml_file)
        hash.each do |key, value|
          ENV[key.upcase] = value.to_s if value
        end
      end
    end
  end
end
