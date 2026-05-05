package org.fujitsu.training.codes.model.form;

public class ResetPasswordForm {
	private String email; 
	private String resetCode; 
	private String newPassword; 
	private String confirmPassword; 

	public ResetPasswordForm() {
		super(); // Default constructor
	}

	public ResetPasswordForm(String email, String resetCode, String newPassword, String confirmPassword) {
		super();
		this.email = email; 
		this.resetCode = resetCode; 
		this.newPassword = newPassword;
		this.confirmPassword = confirmPassword; 
	}

	public String getEmail() {
		return email; 
	}

	public void setEmail(String email) {
		this.email = email; 
	}

	public String getResetCode() {
		return resetCode; 
	}

	public void setResetCode(String resetCode) {
		this.resetCode = resetCode;
	}

	public String getNewPassword() {
		return newPassword; 
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword; 
	}

	public String getConfirmPassword() {
		return confirmPassword; 
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword; 
	}
}