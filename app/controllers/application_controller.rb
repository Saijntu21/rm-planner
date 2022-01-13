class ApplicationController < ActionController::Base
	config.logger = Logger.new(STDOUT)
	config.logger.level = Logger::ERROR
end
