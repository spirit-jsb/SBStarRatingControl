module Fastlane
  module Actions
    module SharedValues
      FL_BUILD_NUMBER = :BUILD_NUMBER
    end
    class SyncBuildNumberToGitAction < Action
      def self.is_git?
        Actions.sh 'git rev-parse HEAD'
        return true
      rescue
        return false
      end
        
      def self.run(params)
        if is_git?
          command = 'git rev-list HEAD --count'
        else
          raise "Not in a git repository."
        end
      build_number = (Actions.sh command).strip
      Fastlane::Actions::IncrementBuildNumberAction.run(build_number: build_number)
      Actions.lane_context[SharedValues::FL_BUILD_NUMBER] = build_number
      end

      def self.output
        [
          ['FL_BUILD_NUMBER', 'The new build number']
        ]
      end

      def self.description
        "Set the build version of your project to the same number of your total git commit count"
      end

      def self.authors
        ["Max"]
      end

      def self.is_supported?(platform)
        [:ios, :mac].include? platform
      end
    end
  end
end
