# frozen_string_literal: true

require 'spec_helper'

describe Crystalball::MapGenerator::Helpers::PathFilter do
  describe '#filter' do
    subject { helper.filter(paths) }

    context 'when no exclude source is given' do
      let(:helper) { Class.new.tap { |c| c.include described_class }.new(root) }
      let(:root) { '/foo' }
      let(:paths) { ['/foo/file.rb', '/abc/file1.rb'] }

      it 'takes paths relative too root only' do
        is_expected.to eq(%w[file.rb])
      end
    end

    context 'when given a source to exlcude' do
      let(:helper) do
        Class.new.tap { |c| c.include described_class }.new(root, exclude_sources: exclude_sources)
      end
      let(:root) { '/foo' }
      let(:exclude_sources) { [%r{vendor/}] }
      let(:paths) { ['/foo/file.rb', '/foo/vendor/file.rb'] }

      it 'excludes given sources' do
        is_expected.to eq(%w[file.rb])
      end
    end
  end
end
