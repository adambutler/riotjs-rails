require 'riotjs-rails/template'

RSpec.describe Riot::Rails::Template do
  let(:template) do
    Riot::Rails::Template.new do
<<-TAG
<message>
  <p>{ begin } { end }</p>

  this.begin = 'Hello';
  this.end = "world";
</message>
TAG
    end
  end

  it 'works' do
    expected = <<-JS
riot.tag('message', '<p>{ begin } { end }</p>', function(opts) {

  this.begin = 'Hello';
  this.end = "world";

});
JS
    expect(template.render).to eq(expected)
  end
end
