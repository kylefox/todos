require 'rails_helper'

RSpec.describe Todo, type: :model do
  fixtures :todos

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(255) }
    it { should validate_length_of(:description).is_at_most(1000) }
  end

  describe 'database columns' do
    it { should have_db_column(:title).of_type(:string).with_options(null: false) }
    it { should have_db_column(:description).of_type(:text) }
    it { should have_db_column(:completed).of_type(:boolean).with_options(default: false, null: false) }
    it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  describe 'database indexes' do
    it { should have_db_index(:completed) }
    it { should have_db_index(:created_at) }
  end

  describe 'defaults' do
    subject { Todo.new }

    its(:completed) { is_expected.to eq(false) }
  end

  describe 'scopes' do
    describe '.completed' do
      it 'returns only completed todos' do
        expect(Todo.completed).to contain_exactly(todos(:call_dentist))
      end
    end

    describe '.incomplete' do
      it 'returns only incomplete todos' do
        expect(Todo.incomplete).to contain_exactly(
          todos(:buy_milk),
          todos(:finish_report),
          todos(:empty_description),
          todos(:long_title)
        )
      end
    end

    describe '.recent' do
      before do
        Todo.destroy_all
        @oldest = Todo.create!(title: "Oldest", created_at: 3.days.ago)
        @newest = Todo.create!(title: "Newest", created_at: 1.day.ago)
        @middle = Todo.create!(title: "Middle", created_at: 2.days.ago)
      end

      it 'orders todos by creation date descending' do
        expect(Todo.recent).to eq([ @newest, @middle, @oldest ])
      end
    end
  end

  describe 'broadcasting' do
    it 'broadcasts on create' do
      expect {
        Todo.create!(title: "New todo")
      }.to have_broadcasted_to("todos")
    end

    it 'broadcasts on update' do
      todo = Todo.create!(title: "Test Todo")
      expect {
        todo.update!(completed: true)
      }.to have_broadcasted_to("todos")
    end

    it 'broadcasts on destroy' do
      todo = Todo.create!(title: "Test Todo")
      expect {
        todo.destroy!
      }.to have_broadcasted_to("todos")
    end
  end

  describe 'edge cases' do
    context 'with empty description' do
      subject { Todo.new(title: "No description", description: "") }

      it { is_expected.to be_valid }
    end

    context 'with nil description' do
      subject { Todo.new(title: "No description", description: nil) }

      it { is_expected.to be_valid }
    end

    context 'with title longer than 255 characters' do
      subject { Todo.new(title: "A" * 256) }

      it { is_expected.not_to be_valid }

      it 'has the correct error message' do
        subject.valid?
        expect(subject.errors[:title]).to include("is too long (maximum is 255 characters)")
      end
    end

    context 'with description longer than 1000 characters' do
      subject { Todo.new(title: "Valid", description: "A" * 1001) }

      it { is_expected.not_to be_valid }

      it 'has the correct error message' do
        subject.valid?
        expect(subject.errors[:description]).to include("is too long (maximum is 1000 characters)")
      end
    end
  end
end
