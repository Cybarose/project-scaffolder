# frozen_string_literal: true

require "spec_helper"

RSpec.describe Proj::TemplateStore do
  describe ".default" do
    it "returns a store with predefined templates" do
      store = described_class.default
      template_names = store.all.map(&:name)

      %w[ruby python esp32 generic node python-docker web-frontend rust go cpp].each do |name|
        expect(template_names).to include(name), "expected default templates to include '#{name}'"
      end
    end
  end

  describe "#fetch" do
    let(:store) { described_class.default }

    it "returns the template by name when it exists" do
      template = store.fetch("ruby")
      expect(template).to be_a(Proj::Template)
      expect(template.name).to eq("ruby")
    end

    it "raises an ArgumentError with a helpful message when the template is unknown" do
      expect { store.fetch("unknown-template") }
        .to raise_error(ArgumentError) { |error|
          expect(error.message).to include("Unknown template 'unknown-template'")
        }
    end
  end
end
