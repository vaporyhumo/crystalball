# frozen_string_literal: true

module Crystalball
  class MapGenerator
    module Helpers
      # Helper module to filter file paths
      module PathFilter
        attr_reader :root_path, :exclude_sources


        # @param [String] root_path - absolute path to root folder of repository
        # @param [Array<String>] exlcude_sources - TODO: add comment 
        def initialize(root_path = Dir.pwd, exclude_sources: [%r{vendor/}])
          @root_path = root_path
          @exclude_sources = exclude_sources
        end

        # @param [Array<String>] paths
        # @return relatve paths inside root_path only
        def filter(paths)
          paths
            .select { |file_name| file_name.start_with?(root_path) }
            .map    { |file_name| file_name.sub("#{root_path}/", '') }
            .reject { |file_name| matches_exclude_source?(file_name) }
        end

        # @param [String] file path
        # @return - TODO: add comment
        def matches_exclude_source?(file_name)
          exclude_sources.any? { |exclude_source| exclude_source.match?(file_name) }
        end
      end
    end
  end
end
