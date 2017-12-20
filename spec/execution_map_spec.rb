# frozen_string_literal: true

require 'spec_helper'

describe Crystalball::ExecutionMap do
  subject { described_class.new }
  let(:coverage) { double }
  let(:case_map) { instance_double(Crystalball::CaseMap, case_uid: 'file_spec.rb:1', coverage: coverage) }

  describe '#<<' do
    it 'adds case to data' do
      expect do
        subject << case_map
      end.to change { subject.cases }.to('file_spec.rb:1' => coverage)
    end
  end

  describe 'clear!' do
    it 'wipes out all cases' do
      subject << case_map
      expect do
        subject.clear!
      end.to change { subject.cases.size }.by(-1)
    end
  end
end