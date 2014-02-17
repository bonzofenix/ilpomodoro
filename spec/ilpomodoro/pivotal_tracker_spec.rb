require 'spec_helper'

describe Ilpomodoro::PivotalTracker do
  include Cancun::Highline
  let(:story){ PivotalTracker::Story.new( name: 'a task') }
  let(:stories){ [story] }
  let(:project) do
    PivotalTracker::Project.new( name: 'project').tap do |p|
      p.stub( stories: double(all: stories))
    end
  end

  let(:other_project){ PivotalTracker::Project.new( name: 'other project') }
  let(:projects){ [project, other_project] }

  let(:pivotal_tracker) do
    described_class.new
  end

  before do
    PivotalTracker::Project.stub(all: projects)
    init_cancun_highline
  end


  it '.login' do
    PivotalTracker::Client.should_receive(:token)
    execute do
      pivotal_tracker.login
    end.and_type "username", 'password'
  end

  describe 'when chooseing project' do
    before do
      execute do
        pivotal_tracker.project
      end.and_type "1"
    end

    it 'selects the correct project' do
      expect(pivotal_tracker.project).to eq(project)
    end

    it 'list all the task of a project' do
      expect(pivotal_tracker.stories).to eq(stories)
    end
  end
end
