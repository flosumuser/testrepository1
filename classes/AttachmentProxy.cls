public with sharing class AttachmentProxy {

	public static String response {get; set;}

	public AttachmentProxy() {
		String attachmentId;
		response = '';

		if (ApexPages.currentPage() != NULL) {
			attachmentId = ApexPages.currentPage().getParameters().get('attachmentid');

			if (!String.isBlank(attachmentId)) {
				List<SObject> record = [SELECT Body FROM Attachment WHERE Id = :attachmentId LIMIT 1];

				if (!record.isEmpty()) {
					response = EncodingUtil.base64Encode((Blob)record.get(0).get('Body'));
				}
			}
		}
	}
}