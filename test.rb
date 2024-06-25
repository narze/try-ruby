require "rspec"

RSpec.describe 'An example test' do
  it 'should pass' do
    expect(1+1).to eq 2
  end

  it 'should pass' do
    expect([1] * 3).to eq [1,1,1]
  end

  it 'should fail' do
    expect(1+1).to eq 3
  end
end
