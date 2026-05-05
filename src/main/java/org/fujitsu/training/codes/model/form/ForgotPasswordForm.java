package org.fujitsu.training.codes.model.form;

public class ForgotPasswordForm {
	private String email; 

	public ForgotPasswordForm() {
		super();
	}

	public ForgotPasswordForm(String email) {
		super();
		this.email = email; 
	}

	public String getEmail() {
		return email; 
	}

	public void setEmail(String email) {
		this.email = email; 
	}
}