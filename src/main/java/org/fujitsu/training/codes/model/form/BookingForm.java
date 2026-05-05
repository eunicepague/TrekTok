package org.fujitsu.training.codes.model.form;

public class BookingForm {
	private Integer packageId; 
	private Integer optionId; 
	private String comments; 
	private String travelDate; 
	
	public BookingForm() {} 

	public BookingForm(Integer packageId, Integer optionId, String comments, String travelDate) {
		super();
		this.packageId = packageId; 
		this.optionId = optionId; 
		this.comments = comments; 
		this.travelDate = travelDate; 
	}

	public Integer getPackageId() {
		return packageId; 
	}

	public void setPackageId(Integer packageId) {
		this.packageId = packageId; 
	}

	public Integer getOptionId() {
		return optionId; 
	}

	public void setOptionId(Integer optionId) {
		this.optionId = optionId;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments; 
	}

	public String getTravelDate() {
		return travelDate; 
	}

	public void setTravelDate(String travelDate) {
		this.travelDate = travelDate; 
	}
}