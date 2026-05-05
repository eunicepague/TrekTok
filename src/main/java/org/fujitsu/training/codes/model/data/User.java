package org.fujitsu.training.codes.model.data;

import java.time.LocalDateTime;

public class User {
	private Integer userId;
	private String firstName;
	private String lastName;
	private String email;
	private String password;
	private String contactNo;
	private Boolean isVerified;
	private String verificationCode;
	private String role;
	private String accountStatus;
	private String resetCode;
	private LocalDateTime resetCodeExpiry;
	
	public User() {}

	public User(Integer userId, String firstName, String lastName, String email, String password, String contactNo,
			Boolean isVerified, String verificationCode, String role, String accountStatus, String resetCode,
			LocalDateTime resetCodeExpiry) {
		super();
		this.userId = userId;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.password = password;
		this.contactNo = contactNo;
		this.isVerified = isVerified;
		this.verificationCode = verificationCode;
		this.role = role;
		this.accountStatus = accountStatus;
		this.resetCode = resetCode;
		this.resetCodeExpiry = resetCodeExpiry;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getContactNo() {
		return contactNo;
	}

	public void setContactNo(String contactNo) {
		this.contactNo = contactNo;
	}

	public Boolean getIsVerified() {
		return isVerified;
	}

	public void setIsVerified(Boolean isVerified) {
		this.isVerified = isVerified;
	}

	public String getVerificationCode() {
		return verificationCode;
	}

	public void setVerificationCode(String verificationCode) {
		this.verificationCode = verificationCode;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getAccountStatus() {
		return accountStatus;
	}

	public void setAccountStatus(String accountStatus) {
		this.accountStatus = accountStatus;
	}

	public String getResetCode() {
		return resetCode;
	}

	public void setResetCode(String resetCode) {
		this.resetCode = resetCode;
	}

	public LocalDateTime getResetCodeExpiry() {
		return resetCodeExpiry;
	}

	public void setResetCodeExpiry(LocalDateTime resetCodeExpiry) {
		this.resetCodeExpiry = resetCodeExpiry;
	}
}