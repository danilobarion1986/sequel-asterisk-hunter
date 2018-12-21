require_relative "../../spec_helper"

Sequel.extension :asterisk_hunter

describe Sequel::Extensions::AsteriskHunter do
  before { Sequel::Dataset.send(:include, Sequel::Extensions::AsteriskHunter) }
  let(:db) { Sequel.mock }

  context "when adapter is Postgres" do
    describe "#hunt" do
      context 'when the dataset contains some "SELECT *" statement' do
        subject { db[:users] }

        it 'returns truthy' do
          expect(subject.hunt).to eql('Find it!')
        end
      end

      context 'when the dataset do not contains any "SELECT *" statement' do
        subject { db[:users].select(:id) }

        it 'returns truthy' do
          expect(subject.hunt).to eql(subject)
        end
      end
    end
  end
end
