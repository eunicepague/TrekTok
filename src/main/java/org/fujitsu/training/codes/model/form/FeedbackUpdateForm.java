package org.fujitsu.training.codes.model.form;

public class FeedbackUpdateForm {
	private Integer feedbackId; 
	private String adminRemarks; 
	private String status; 
	
	public FeedbackUpdateForm() {} 

	public FeedbackUpdateForm(Integer feedbackId, String adminRemarks, String status) {
		super();
		this.feedbackId = feedbackId; 
		this.adminRemarks = adminRemarks; 
		this.status = status; 
	}

	public Integer getFeedbackId() {
		return feedbackId; 
	}

	public void setFeedbackId(Integer feedbackId) {
		this.feedbackId = feedbackId; 
	}

	public String getAdminRemarks() {
		return adminRemarks; 
	}

	public void setAdminRemarks(String adminRemarks) {
		this.adminRemarks = adminRemarks; 
	}

	public String getStatus() {
		return status; 
	}

	public void setStatus(String status) {
		this.status = status; 
	}
	
	
}