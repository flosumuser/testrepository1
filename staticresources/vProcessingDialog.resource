// Requires jQuery
// Requires KendoUI

(function($) {
	$.fn.vProcessingDialog = function(options) {
		var settings = $.extend({
			text: "Saving...",
			width: "300px",
			height: "100px",
		}, options);

		// create the kendo saving dialog on this selector
		var kendoWindow = this.kendoWindow({
			width: settings.width,
			height: settings.height, 
			actions: {},
			modal: true,
			visible: false,
			draggable: false,
			resizable: false,
			title: settings.text
		}).data("kendoWindow");

		// find the processing text v-processing-text and set the
		// text that is passed in
		this.find("#v-processing-text").html(settings.text);

		var internalProcessingDialog = {
			show: function() {
				kendoWindow.center().open();
			},
			hide: function() {
				kendoWindow.close();
			}
		};

		this.data("vProcessingDialog", internalProcessingDialog);

		return this;
	}
})(jQuery);