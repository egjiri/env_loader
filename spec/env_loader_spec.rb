require 'spec_helper'
require 'uiux'

describe EnvLoader do
  it 'has a version number' do
    expect(EnvLoader::VERSION).not_to be_nil
  end

  context '#setup_monolith' do
    it 'should initialize Configurator using a .monolith-config.yml file at the root of the app' do
      expect(EnvLoader::Configurator).to receive(:new).with(config_file: '.monolith-config.yml', config_content: nil, config_subtree_key: nil)
      EnvLoader.setup_monolith
    end
  end

  context '#setup_microservice' do
    it 'should initialize Configurator using a .microservices-config.yml file located at the parent directory' do
      expect(EnvLoader::Configurator).to receive(:new).with(config_file: '../.microservices-config.yml', config_content: nil, config_subtree_key: nil)
      EnvLoader.setup_microservice
    end
  end

  context '#read (DEPRECATED)' do
    it 'should initialize Configurator using an env_variables.yml file located in the config directory' do
      expect(EnvLoader::Configurator).to receive(:new).with(config_file: 'config/env_variables.yml', config_content: nil, config_subtree_key: nil)
      EnvLoader.read
    end
  end
end
