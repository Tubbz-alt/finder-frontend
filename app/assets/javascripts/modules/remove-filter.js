window.GOVUK = window.GOVUK || {};
window.GOVUK.Modules = window.GOVUK.Modules || {};

(function (global, GOVUK) {
  'use strict';

  GOVUK.Modules.RemoveFilter = function () {
    this.start = function (element) {
      $(element).on('click', '[data-module="remove-filter-link"]', toggleFilter);
    };

    function toggleFilter(e) {
      e.preventDefault();

      var removeFilterName = $(this).data('name');
      var removeFilterValue = $(this).data('value');
      var removeFilterFacet = $(this).data('facet');

      var inputSelector = getSelectorForInput(removeFilterName, removeFilterValue);
      var $input = $('#' + removeFilterFacet).find(inputSelector);

      var elementType = $input.prop('tagName');
      var inputType = $input.prop('type');

      setInputState(elementType, inputType, $input, removeFilterValue, removeFilterFacet);
    }

    function setInputState(elementType, inputType, $input, removeFilterValue, removeFilterFacet) {
      if (inputType == 'checkbox') {
        $input.prop("checked", false);
        $input.trigger('change');
      }
      else if (inputType == 'text' || inputType == 'search') {
        var currentVal = $input.val();
        var newVal = $.trim(currentVal.replace(removeFilterValue, ''));

        $input.val(newVal).trigger('change');
      }
      else if (elementType == 'OPTION') {
        $('#' + removeFilterFacet).val("").trigger('change');
      }
    };

    function getSelectorForInput(removeFilterName, removeFilterValue) {
      if (!!removeFilterName) {
        return " input[name='" + removeFilterName + "']";
      } else {
        return " [value='" + removeFilterValue + "']";
      }
    }
  }
})(window, window.GOVUK);