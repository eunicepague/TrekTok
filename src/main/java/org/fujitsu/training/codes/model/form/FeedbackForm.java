package org.fujitsu.training.codes.model.form;

public class FeedbackForm {
	private String message; 
	private Integer rating; 
	
	public FeedbackForm() {} 

	public FeedbackForm(String message, Integer rating) {
		super();
		this.message = message; 
		this.rating = rating; 
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
	
	
}