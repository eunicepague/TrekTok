package org.fujitsu.training.codes.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.fujitsu.training.codes.model.data.User;
import org.fujitsu.training.codes.model.form.ForgotPasswordForm;
import org.fujitsu.training.codes.model.form.LoginForm;
import org.fujitsu.training.codes.model.form.RegisterForm;
import org.fujitsu.training.codes.model.form.ResetPasswordForm;
import org.fujitsu.training.codes.model.form.VerifyForm;
import org.fujitsu.training.codes.service.EmailService;
import org.fujitsu.training.codes.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpSession;

@Controller // Marks this class as a Spring MVC controller
public class AuthController {
	
	private static final Logger LOG = LogManager.getLogger(AuthController.class); // Logger for auth actions
	
	@Autowired
	private UserService userService; // Service for user-related actions
	
	@Autowired
	private EmailService emailService; // Service for sending emails

	@GetMapping("/login")
	public String showLogin(Model model) {
		LOG.info("Login page opened.");
		model.addAttribute("loginForm", new LoginForm()); // Sends empty login form to JSP
		return "login";
	}
	
	@PostMapping("/login")
	public String processLogin(@ModelAttribute("loginForm") LoginForm form,
			Model model,
			HttpSession session) {
		
		String email = form.getEmail() == null ? "" : form.getEmail().trim(); // Gets trimmed email input
		String password = form.getPassword() == null ? "" : form.getPassword().trim(); // Gets trimmed password input
		
		LOG.info("Login attempt for email={}", email);
		
		if (email.isBlank() || password.isBlank()) { // Checks if required fields are blank
			LOG.error("Login failed: email or password is blank for email={}", email);
			model.addAttribute("error", "Email and password are required.");
			return "login";
		}
		
		User rec = userService.login(email, password); // Calls service to validate login
		
		if (rec != null) {
			session.setAttribute("user", rec); // Stores logged-in user in session
			
			LOG.info("Login successful for userId={}, email={}, role={}", rec.getUserId(), rec.getEmail(), rec.getRole());
			
			if ("ADMIN".equalsIgnoreCase(rec.getRole()) || "SUPER_ADMIN".equalsIgnoreCase(rec.getRole())) { // Redirects admin users
				LOG.info("Redirecting admin userId={} to /admin", rec.getUserId());
				return "redirect:/admin";
			}
			
			LOG.info("Redirecting customer userId={} to /home", rec.getUserId()); // Redirects customer users
			return "redirect:/home";
		}
		
		LOG.error("Login failed for email={}: invalid credentials, not verified, or inactive.", email);
		model.addAttribute("error", "Invalid email/password, account not verified, or account inactive.");
		return "login";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session, Model model) {
		Object userObj = session.getAttribute("user"); // Gets user object from session
		
		if (userObj instanceof User user) { // Checks if session has valid user object
			LOG.info("Logout successful for userId={}, email={}", user.getUserId(), user.getEmail());
		} else {
			LOG.info("Logout called with no active user session.");
		}
		
		session.invalidate(); // Clears the current session
		model.addAttribute("message", "You have been logged out successfully.");
		model.addAttribute("loginForm", new LoginForm()); // Sends new login form back to page
		return "login";
	}
	
	@GetMapping("/register")
	public String showRegister(Model model) {
		LOG.info("Registration page opened.");
		model.addAttribute("registerForm", new RegisterForm()); // Sends empty register form to JSP
		return "register";
	}
	
	@PostMapping("/register")
	public String processRegister(@ModelAttribute("registerForm") RegisterForm form,
			Model model) {
		
		String firstName = form.getFirstName() == null ? "" : form.getFirstName().trim(); // Gets trimmed first name
		String lastName = form.getLastName() == null ? "" : form.getLastName().trim(); // Gets trimmed last name
		String email = form.getEmail() == null ? "" : form.getEmail().trim(); // Gets trimmed email
		String contactNo = form.getContactNo() == null ? "" : form.getContactNo().trim(); // Gets trimmed contact number
		String password = form.getPassword() == null ? "" : form.getPassword().trim(); // Gets trimmed password
		String confirmPassword = form.getConfirmPassword() == null ? "" : form.getConfirmPassword().trim(); // Gets trimmed confirm password
		
		LOG.info("Registration attempt for email={}", email);
		
		if (firstName.isBlank() || lastName.isBlank() || email.isBlank() ||
			contactNo.isBlank() || password.isBlank() || confirmPassword.isBlank()) { // Checks if any required field is blank
			
			LOG.error("Registration failed for email={}: one or more required fields are blank.", email);
			model.addAttribute("error", "All fields are required.");
			model.addAttribute("registerForm", form);
			return "register";
		}
		
		if (!email.contains("@") || !email.contains(".")) { // Simple email format check
			LOG.error("Registration failed for email={}: invalid email format.", email);
			model.addAttribute("error", "Please enter a valid email address.");
			model.addAttribute("registerForm", form);
			return "register";
		}
		
		if (!password.equals(confirmPassword)) { // Checks if passwords match
			LOG.error("Registration failed for email={}: password and confirm password do not match.", email);
			model.addAttribute("error", "Password and confirm password do not match.");
			model.addAttribute("registerForm", form);
			return "register";
		}
		
		if (!contactNo.matches("\\d{11}")) { // Checks if contact number is exactly 11 digits
			LOG.error("Registration failed for email={}: invalid contact number.", email);
			model.addAttribute("error", "Contact number must be exactly 11 digits.");
			model.addAttribute("registerForm", form);
			return "register";
		}
		
		String code = userService.register(firstName, lastName, email, password, contactNo); // Calls service to register user
		
		if (code != null) {
			boolean sent = emailService.sendEmail(
					email,
					"TrekTok Verification Code",
					"Hello " + firstName + ", your verification code is: " + code); // Sends verification code email

			LOG.info("Registration successful for email={}", email);
			LOG.info("Verification email send result for email={} is {}", email, sent);
			
			model.addAttribute("verifyForm", new VerifyForm(email, "")); // Prepares verify form with email
			model.addAttribute("email", email);
			
			if (sent) {
				model.addAttribute("message", "Registration successful. Please check your email for the verification code.");
			} else {
				LOG.error("Verification email sending failed for email={}", email);
				model.addAttribute("message", "Registration successful, but email sending failed. Please use the code shown in the server console.");
			}
			
			return "verify";
		}
		
		LOG.error("Registration failed: email already exists for email={}", email);
		model.addAttribute("error", "Email already exists.");
		model.addAttribute("registerForm", form);
		return "register";
	}
	
	@GetMapping("/verify")
	public String showVerify(Model model) {
		LOG.info("Verification page opened.");
		model.addAttribute("verifyForm", new VerifyForm()); // Sends empty verify form to JSP
		return "verify";
	}
	
	@PostMapping("/verify")
	public String processVerify(@ModelAttribute("verifyForm") VerifyForm form,
			Model model) {
		
		String email = form.getEmail() == null ? "" : form.getEmail().trim(); // Gets trimmed email
		String verificationCode = form.getVerificationCode() == null ? "" : form.getVerificationCode().trim(); // Gets trimmed verification code
		
		LOG.info("Verification attempt for email={}", email);
		
		if (email.isBlank() || verificationCode.isBlank()) { // Checks if email or code is blank
			LOG.error("Verification failed for email={}: email or verification code is blank.", email);
			model.addAttribute("error", "Email and verification code are required.");
			model.addAttribute("email", email);
			model.addAttribute("verifyForm", form);
			return "verify";
		}
		
		boolean res = userService.verifyUser(email, verificationCode); // Calls service to verify account
		
		if (res) {
			LOG.info("Account verification successful for email={}", email);
			model.addAttribute("message", "Account verified successfully. You may now log in.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		LOG.error("Account verification failed for email={}: invalid verification code.", email);
		model.addAttribute("error", "Invalid verification code.");
		model.addAttribute("email", email);
		model.addAttribute("verifyForm", new VerifyForm(email, ""));
		return "verify";
	}

	@GetMapping("/forgot-password")
	public String showForgotPassword(Model model) {
		LOG.info("Forgot password page opened.");
		model.addAttribute("forgotPasswordForm", new ForgotPasswordForm()); // Sends empty forgot password form to JSP
		return "forgot-password";
	}

	@PostMapping("/forgot-password")
	public String processForgotPassword(@ModelAttribute("forgotPasswordForm") ForgotPasswordForm form,
			Model model) {
		
		String email = form.getEmail() == null ? "" : form.getEmail().trim(); // Gets trimmed email input
		
		LOG.info("Forgot password attempt for email={}", email);
		
		if (email.isBlank()) { // Checks if email is blank
			LOG.error("Forgot password failed: email is blank.");
			model.addAttribute("error", "Email is required.");
			model.addAttribute("forgotPasswordForm", form);
			return "forgot-password";
		}
		
		String resetCode = userService.createResetCode(email); // Generates reset code through service
		
		if (resetCode == null) {
			LOG.error("Forgot password failed: email not found for email={}", email);
			model.addAttribute("error", "Email not found.");
			model.addAttribute("forgotPasswordForm", form);
			return "forgot-password";
		}
		
		boolean sent = emailService.sendEmail(
				email,
				"TrekTok Password Reset Code",
				"Your password reset code is: " + resetCode + ". This code will expire in 10 minutes."); // Sends reset code email
		
		LOG.info("Reset code generated for email={}", email);
		LOG.info("Reset email send result for email={} is {}", email, sent);
		
		model.addAttribute("resetPasswordForm", new ResetPasswordForm(email, "", "", "")); // Prepares reset password form
		
		if (sent) {
			model.addAttribute("message", "Reset code sent successfully. Please check your email.");
		} else {
			LOG.error("Reset email sending failed for email={}", email);
			model.addAttribute("message", "Reset code generated, but email sending failed. Please use the code shown in the server console.");
		}
		
		return "reset-password";
	}

	@GetMapping("/reset-password")
	public String showResetPassword(Model model) {
		LOG.info("Reset password page opened.");
		model.addAttribute("resetPasswordForm", new ResetPasswordForm()); // Sends empty reset password form to JSP
		return "reset-password";
	}

	@PostMapping("/reset-password")
	public String processResetPassword(@ModelAttribute("resetPasswordForm") ResetPasswordForm form,
			Model model) {
		
		String email = form.getEmail() == null ? "" : form.getEmail().trim(); // Gets trimmed email
		String resetCode = form.getResetCode() == null ? "" : form.getResetCode().trim(); // Gets trimmed reset code
		String newPassword = form.getNewPassword() == null ? "" : form.getNewPassword().trim(); // Gets trimmed new password
		String confirmPassword = form.getConfirmPassword() == null ? "" : form.getConfirmPassword().trim(); // Gets trimmed confirm password
		
		LOG.info("Reset password attempt for email={}", email);
		
		if (email.isBlank() || resetCode.isBlank() || newPassword.isBlank() || confirmPassword.isBlank()) { // Checks if any field is blank
			LOG.error("Reset password failed for email={}: one or more required fields are blank.", email);
			model.addAttribute("error", "All fields are required.");
			model.addAttribute("resetPasswordForm", form);
			return "reset-password";
		}
		
		if (!newPassword.equals(confirmPassword)) { // Checks if passwords match
			LOG.error("Reset password failed for email={}: new password and confirm password do not match.", email);
			model.addAttribute("error", "New password and confirm password do not match.");
			model.addAttribute("resetPasswordForm", form);
			return "reset-password";
		}
		
		boolean res = userService.resetPassword(email, resetCode, newPassword); // Calls service to reset password
		
		if (res) {
			LOG.info("Password reset successful for email={}", email);
			model.addAttribute("message", "Password reset successful. You may now log in.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		LOG.error("Reset password failed for email={}: invalid or expired reset code.", email);
		model.addAttribute("error", "Invalid or expired reset code.");
		model.addAttribute("resetPasswordForm", form);
		return "reset-password";
	}
}