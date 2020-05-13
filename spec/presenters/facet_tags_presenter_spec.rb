require "spec_helper"
require_relative "./helpers/facets_helper"

describe FacetTagsPresenter do
  include FacetsHelper

  subject(:presenter) { described_class.new(filters, sort_presenter) }

  let(:filters) { [a_facet, another_facet, a_date_facet] }

  let(:sort_presenter) do
    double(
      SortPresenter,
      selected_option: nil,
    )
  end

  describe "#present" do
    it "returns a hash containing expected keys" do
      expect(presenter.present.keys).to contain_exactly(:applied_filters, :screen_reader_filter_description)
    end
  end

  describe "#selected_filter_descriptions" do
    it "includes prepositions for each facet" do
      applied_filters = presenter.selected_filter_descriptions.flat_map { |filter| filter }
      prepositions = applied_filters.flat_map { |filter| filter[:preposition] }.reject { |preposition| preposition == "or" }

      filters.reject { |filter| filter.sentence_fragment.nil? }.each do |fragment|
        expect(prepositions).to include(fragment.sentence_fragment["preposition"])
      end
    end
  end

  describe "display_total_selected_filters" do
    it "displays the count of total filters applied, not the count of filter types applied" do
      expect(presenter.present[:applied_filters].count).to eq 2
      expect(presenter.display_total_selected_filters).to eq("(4)<span class='govuk-visually-hidden'> filters currently selected</span>")
    end
  end
end
