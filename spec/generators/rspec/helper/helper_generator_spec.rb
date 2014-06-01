require 'spec_helper'

# Generators are not automatically loaded by Rails
require 'generators/rspec/helper/helper_generator'

describe Rspec::Generators::HelperGenerator, :type => :generator do
  # Tell the generator where to put its output (what it thinks of as Rails.root)
  destination File.expand_path("../../../../../tmp", __FILE__)

  before { prepare_destination }

  subject { file('spec/helpers/posts_helper_spec.rb') }
  describe 'generated by default' do
    before do
      run_generator %w(posts)
    end

    describe 'the spec' do
      it { is_expected.to exist }
      it { is_expected.to contain(/require 'rails_helper'/) }
      it { is_expected.to contain(/^RSpec.describe PostsHelper, :type => :helper/) }
    end
  end
  describe 'skipped with a flag' do
    before do
      run_generator %w(posts --no-helper_specs)
    end
    it { is_expected.not_to exist }
  end
end
