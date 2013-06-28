require 'spec_helper'

describe Hash do

  describe '#deep_merge' do

    it 'should correctly deep merge hashes' do
      {
        1  => 2,
        :a => :b,
        :c => {
          :d => :e ,
          :f => {
            :g => {
              'h' => :i,
              :j  => {
                :k => {
                  :l => false
                }
              }
            }
          }
        }
      }.deep_merge({
        1 => 3,
        :c => {
          :f => {
            :g => {
              'h' => 'i',
              :j => {
                :k => {
                  :l => true
                }
              }
            }
          }
        }
      }).should == {
        1  => 3,
        :a => :b
        :c => {
          :d => :e,
          :f => {
            :g => {
              'h' => 'i',
              :j  => {
                :k => {
                  :l => true
                }
              }
            }
          }
        }
      }
    end

  end

  describe '#symbolize_keys' do

    it 'symbolizes keys correctly' do
      { 1 => 2, :a => 'b', 'c' => 'd', "efghijklm" => "n", ':"§$%"' => 'o' }.symbolize_keys.should == { 1 => 2, :a => 'b', :c => 'd', :efghijklm => "n", :':"§$%"' => 'o' }
    end

  end

end
