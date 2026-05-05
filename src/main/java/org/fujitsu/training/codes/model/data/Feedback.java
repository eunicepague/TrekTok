package org.fujitsu.training.codes.model.data;

import java.time.LocalDateTime;

public class Feedback {

	private Integer feedbackId;
	private Integer userId;
	private Integer bookingId;
	private String packageName;
	private String email;
	private String contactNo;
	private String message;
	private Integer rating;
	private LocalDateTime feedbackDate;
	private String adminRemarks;
	private String status;
	
	public Feedback() {}

	public Feedback(Integer feedbackId, Integer userId, Integer bookingId, String packageName, String email,
			String contactNo, String message, Integer rating, LocalDateTime feedbackDate,
			String adminRemarks, String status) {
		super();
		this.feedbackId = feedbackId;
		this.userId = userId;
		this.bookingId = bookingId;
		this.packageName = packageName;
		this.email = email;
		this.contactNo = contactNo;
		this.message = message;
		this.rating = rating;
		this.feedbackDate = feedbackDate;
		this.adminRemarks = adminRemarks;
		this.status = status;
	}

	public Integer getFeedbackId() {
		return feedbackId;
	}

	public void setFeedbackId(Integer feedbackId) {
		this.feedbackId = feedbackId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getBookingId() {
		return bookingId;
	}

	public void setBookingId(Integer bookingId) {
		this.bookingId = bookingId;
	}

	public String getPackageName() {
		return packageName;
	}

	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getContactNo() {
		return contactNo;
	}

	public void setContactNo(String contactNo) {
		this.contactNo = contactNo;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Integer getRating() {
		return rating;
	}

	public void setRating(Integer rating) {
		this.rating = rating;
	}

	public LocalDateTime getFeedbackDate() {
		return feedbackDate;
	}

	public void setFeedbackDate(LocalDateTime feedbackDate) {
		this.feedbackDate = feedbackDate;
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