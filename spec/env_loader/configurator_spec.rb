require 'spec_helper'
require 'uiux'

describe EnvLoader::Configurator do
  context 'with config_file' do
    before(:all) do
      @config_file = File.join(File.dirname(__dir__), 'fixtures', 'example-config.yml')
      @config_hash = {
        'first-app' => {
          'default' => {
            'service_database_url' => 'first-secret'
          },
          'name-reaction' => {
            'service_database_url' => 'first-secret'
          }
        },
        'second-app' => {
          'default' => {
            'service_database_url' => 'second-secret'
          },
          'name-reaction' => {
            'service_database_url' => 'second-secret'
          }
        }
      }
    end

    context 'invalid config_file' do
      it 'must have a blank hash as the raw_config' do
        expect(EnvLoader::Configurator.new(config_file: 'invalid').raw_config).to eq({})
      end
    end

    context 'valid config_file' do
      it 'must convert the config file to environment variables' do
        configurator = EnvLoader::Configurator.new(config_file: @config_file)
        expect(configurator.raw_config).to eq(@config_hash)

        expect(ENV['FIRST-APP']).to be_nil
        expect(ENV['SECOND-APP']).to be_nil
        configurator.expose_values_as_environment_variables
        expect(ENV['FIRST-APP']).to eq("{\"default\":{\"service_database_url\":\"first-secret\"},\"name-reaction\":{\"service_database_url\":\"first-secret\"}}")
        expect(ENV['SECOND-APP']).to eq("{\"default\":{\"service_database_url\":\"second-secret\"},\"name-reaction\":{\"service_database_url\":\"second-secret\"}}")
      end

      it 'must extract a subset of the config_file into the raw_config hash if a config_subtree_key is passed' do
        configurator = EnvLoader::Configurator.new(config_file: @config_file, config_subtree_key: 'second-app.name-reaction')
        expect(configurator.raw_config).to eq('service_database_url' => 'second-secret')

        expect(ENV['SERVICE_DATABASE_URL']).to be_nil
        configurator.expose_values_as_environment_variables
        expect(ENV['SERVICE_DATABASE_URL']).to eq('second-secret')
      end
    end
  end

  context 'with config_content' do
    before(:all) do
      @config_content = %(
        first:
          deep: 'first secret value'
        second:
          deep: 'second secret value'
      )
      @config_hash = {
        'first' => {
          'deep' => 'first secret value'
        },
        'second' => {
          'deep' => 'second secret value'
        }
      }
    end

    it 'must convert the config file to environment variables' do
      configurator = EnvLoader::Configurator.new(config_content: @config_content)
      expect(configurator.raw_config).to eq(@config_hash)

      expect(ENV['FIRST']).to be_nil
      expect(ENV['SECOND']).to be_nil
      configurator.expose_values_as_environment_variables
      expect(ENV['FIRST']).to eq("{\"deep\":\"first secret value\"}")
      expect(ENV['SECOND']).to eq("{\"deep\":\"second secret value\"}")
    end

    it 'must extract a subset of the config_content into the raw_config hash if a config_subtree_key is passed' do
      configurator = EnvLoader::Configurator.new(config_content: @config_content, config_subtree_key: 'second')
      expect(configurator.raw_config).to eq('deep' => 'second secret value')

      expect(ENV['DEEP']).to be_nil
      configurator.expose_values_as_environment_variables
      expect(ENV['DEEP']).to eq('second secret value')
    end
  end
end
