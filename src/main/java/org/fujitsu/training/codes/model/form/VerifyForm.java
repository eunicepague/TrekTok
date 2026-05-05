package org.fujitsu.training.codes.model.form;

public class VerifyForm {

	private String email; // Stores user email
	private String verificationCode; // Stores email verification code
	
	public VerifyForm() {} // Default constructor

	public VerifyForm(String email, String verificationCode) {
		super();
		this.email = email; // Initializes email
		this.verificationCode = verificationCode; // Initializes verification code
	}

	public String getEmail() {
		return email; // Returns email
	}

	public void setEmail(String email) {
		this.email = email; // Sets email
	}

	public String getVerificationCode() {
		return verificationCode; // Returns verification code
	}

	public void setVerificationCode(String verificationCode) {
		this.verificationCode = verificationCode; // Sets verification code
	}
	
	
}