/**
 * This method will check form validations form elements should contain custom
 * attribute 'validations' with key value pair various validations pairs -
 * notNull:<true/false>,dataType:<dataTypeValue>,size:<Max_size>
 * 
 * @param formId
 * @returns {Boolean}
 */
function validateForm(formId) {
	var $form_elements = $("#" + formId).find("input,select,textarea");
	var isValid = true;
	$($form_elements).each( function() {
			console.log("Tag Name:" + $(this).prop('tagName'));
			console.log("Type: " + $(this).prop('type'));
			if ($(this).attr('validations') != undefined) {
				if ($(this).prop('tagName') == 'INPUT'
						|| $(this).prop('tagName') == 'TEXTAREA'
						|| $(this).prop('tagName') == 'SELECT') {

					console.log("form:" + this);
					var validations = $(this).attr('validations');
					console.log("validations:" + validations);
					var metaDataArray = validations.split(',');
					console.log("meta data length:"
							+ metaDataArray.length);
					var addClass = false;
					$('.error').remove();
					var msg = "";
					for (var i = 0; i < metaDataArray.length; i++) {
						var metaDataKey = metaDataArray[i]
								.split(":")[0].trim();
						var metaDataValue = metaDataArray[i]
								.split(":")[1].trim();
						console.log("meta data key:" + metaDataKey);
						console.log("meta data value:"
								+ metaDataValue);
						if (metaDataKey == 'notNull'
								&& metaDataValue == 'true') {

							if ($('#' + $(this).attr('id')).val() == "") {
								isValid = false;
								addClass = true;
								msg += "Please enter value for " + $("label[for='" + $(this).attr('id') + "']").html();
								break;
							}
						} else if (metaDataKey == 'dataType'
								&& metaDataValue == 'INT') {
							console.log("Is NAN:"
									+ isNaN($(
											'#'
													+ $(this).attr(
															'id'))
											.val()));
							if (isNaN($('#' + $(this).attr('id'))
									.val())) {
								isValid = false;
								addClass = true;
								msg += "Only numbers allowed in this field.&nbsp;";
								break;
							}
						} else if (metaDataKey == 'dataType'
								&& metaDataValue.indexOf('BLOB') != -1
								&& $('#' + $(this).attr('id'))
										.val() != null
								&& $('#' + $(this).attr('id'))
										.val() != ""
								&& !checkFileSize($(this)
										.attr('id'))) {
							// console.log("Is
							// NAN:"+isNaN($('#'+$(this).attr('id')).val()));
							isValid = false;
							addClass = true;
							msg += "Please select file smalled than .&nbsp;";
							break;
						} else if (metaDataKey == 'size'
								&& metaDataValue < $(
										'#' + $(this).attr('id'))
										.val().length) {
							isValid = false;
							addClass = true;
							msg += "Maximum " + metaDataValue + " characters allowed.&nbsp;";
							break;
						}
					}
					if (addClass) {
						$('#' + $(this).attr('id')).after("<span class='error'>" + msg + "</span>");
						return false;
					}
				}
			}
		});
	console.log("isValid" + isValid);
	return isValid;
}

function showNotificationDialog(message) {
	$('#messageText').html(message)
	$('#msg').show();
	$('#msg').fadeOut(10000);
}