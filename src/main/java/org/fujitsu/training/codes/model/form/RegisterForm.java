package org.fujitsu.training.codes.model.form;

public class RegisterForm {
	private String firstName; // Stores first name
	private String lastName; // Stores last name
	private String email; // Stores email
	private String password; // Stores password
	private String confirmPassword; // Stores confirm password
	private String contactNo; // Stores contact number
	
	public RegisterForm() {} // Default constructor

	public RegisterForm(String firstName, String lastName, String email, String password, String confirmPassword,
			String contactNo) {
		super();
		this.firstName = firstName; // Initializes first name
		this.lastName = lastName; // Initializes last name
		this.email = email; // Initializes email
		this.password = password; // Initializes password
		this.confirmPassword = confirmPassword; // Initializes confirm password
		this.contactNo = contactNo; // Initializes contact number
	}

	public String getFirstName() {
		return firstName; // Returns first name
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName; // Sets first name
	}

	public String getLastName() {
		return lastName; // Returns last name
	}

	public void setLastName(String lastName) {
		this.lastName = lastName; // Sets last name
	}

	public String getEmail() {
		return email; // Returns email
	}

	public void setEmail(String email) {
		this.email = email; // Sets email
	}

	public String getPassword() {
		return password; // Returns password
	}

	public void setPassword(String password) {
		this.password = password; // Sets password
	}

	public String getConfirmPassword() {
		return confirmPassword; // Returns confirm password
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword; // Sets confirm password
	}

	public String getContactNo() {
		return contactNo; // Returns contact number
	}

	public void setContactNo(String contactNo) {
		this.contactNo = contactNo; // Sets contact number
	}	
	
	
}