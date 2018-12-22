require_relative "../../spec_helper"

Sequel.extension :asterisk_hunter

describe Sequel::Extensions::AsteriskHunter do
  before { Sequel::Dataset.send(:include, Sequel::Extensions::AsteriskHunter) }
  let(:db) { Sequel.mock }

  describe "#hunt" do
    context 'when the dataset contains some "SELECT *" statement' do
      subject { db[:users] }

      context 'when no action is defined for the user' do
        it 'returns self' do
          expect(subject.send(:hunt)).to eql(subject)
        end
      end

      context 'when some action is defined for the user' do
        context 'when the action must interrupt the flow' do
          before do
            action = -> { raise StandardError, 'Interrupted' }
            described_class.define_action(action)
          end

          it 'interrupts the flow' do
            expect { subject.send(:hunt) }.to raise_error(StandardError, 'Interrupted')
          end
        end

        context 'when the action do not interrupt the flow' do
          before do
            action = -> { 'Not Interrupted' }
            described_class.define_action(action)
          end

          it 'returns self' do
            expect(subject.send(:hunt)).to eql(subject)
          end
        end
      end
    end

    context 'when the dataset do not contains any "SELECT *" statement' do
      subject { db[:users].select(:id) }

      context 'when no action is defined for the user' do
        it 'returns self' do
          expect(subject.send(:hunt)).to eql(subject)
        end
      end

      context 'when some action is defined for the user' do
        context 'when the action must interrupt the flow' do
          before do
            action = -> { raise StandardError, 'Interrupted' }
            described_class.define_action(action)
          end

          it 'do not interrupts the flow' do
            expect { subject.send(:hunt) }.not_to raise_error
          end
        end

        context 'when the action do not interrupt the flow' do
          before do
            action = -> { 'Not Interrupted' }
            described_class.define_action(action)
          end

          it 'returns self' do
            expect(subject.send(:hunt)).to eql(subject)
          end
        end
      end
    end
  end

  describe '.define_action' do
    context 'when any not callable object is passed as argument' do
      it 'raises TypeError' do
        expect do
          described_class.define_action(1)
        end.to raise_error(TypeError, 'Action parameter must be a callable object!')
      end
    end

    context 'when any callable object is passed as argument' do
      it 'not raises error' do
        expect(described_class.define_action(lambda {})).not_to raise_error
      end
    end
  end
end
