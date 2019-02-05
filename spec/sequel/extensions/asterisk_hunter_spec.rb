# frozen_string_literal: true

require_relative '../../spec_helper'

Sequel.extension :asterisk_hunter

describe Sequel::Extensions::AsteriskHunter do
  before { Sequel::Dataset.send(:include, Sequel::Extensions::AsteriskHunter) }
  subject { dataset.send(:hunt) }
  let(:result) { 0 }

  describe '#hunt' do
    context 'when the dataset contains some "SELECT *" statement' do
      let(:dataset) { Sequel.mock[:users] }

      context 'when no action is defined for the user' do
        it 'return AsteriskHunter::DefaultAction class' do
          result = subject

          expect(result).to eql(described_class::DefaultAction.call)
        end
      end

      context 'when some action is defined for the user' do
        context 'when the action interrupt the execution flow' do
          before do
            action = -> { raise StandardError, 'Interrupted' }
            described_class.define_action(action)
          end

          it 'interrupts the flow' do
            expect { subject }.to raise_error(StandardError, 'Interrupted')
          end
        end

        context 'when the action do not interrupt the execution flow' do
          let(:magic_number) { 5 }

          before do
            action = -> { magic_number }
            described_class.define_action(action)
          end

          it 'is called and do not interrupt the execution flow' do
            result = subject

            expect(result).to eql(magic_number)
          end
        end
      end
    end

    context 'when the dataset do not contains any "SELECT *" statement' do
      let(:dataset) { Sequel.mock[:users].select(:id) }

      context 'when no action is defined for the user' do
        it 'do not return AsteriskHunter::DefaultAction class' do
          result = subject

          expect(result).to eql(nil)
        end
      end

      context 'when some action is defined for the user' do
        context 'when the action interrupt the execution flow' do
          before do
            action = -> { raise StandardError, 'Interrupted' }
            described_class.define_action(action)
          end

          it 'do not interrupts the flow' do
            expect { subject }.not_to raise_error
          end
        end

        context 'when the action do not interrupt the execution flow' do
          let(:magic_number) { 42 }

          before do
            action = -> { magic_number }
            described_class.define_action(action)
          end

          it 'is not called and do not interrupt the execution flow' do
            result = subject

            expect(result).to eql(nil)
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
