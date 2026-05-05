package org.fujitsu.training.codes.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.fujitsu.training.codes.model.data.Booking;
import org.fujitsu.training.codes.model.data.Feedback;
import org.fujitsu.training.codes.model.data.User;
import org.fujitsu.training.codes.model.form.FeedbackForm;
import org.fujitsu.training.codes.model.form.LoginForm;
import org.fujitsu.training.codes.service.BookingService;
import org.fujitsu.training.codes.service.FeedbackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;

@Controller // Spring MVC controller for feedback-related pages/actions
public class FeedbackController {

	private static final Logger LOG = LogManager.getLogger(FeedbackController.class); // Logger for feedback actions

	@Autowired
	private FeedbackService feedbackService; // Service for feedback-related logic
	
	@Autowired
	private BookingService bookingService; // Service for booking-related logic

	@GetMapping("/feedback")
	public String showFeedbackForm(@RequestParam("bookingId") Integer bookingId,
			Model model,
			HttpSession session) {
		
		User user = (User) session.getAttribute("user"); // Gets current logged-in user from session
		if (user == null) { // Blocks access if no logged-in user
			LOG.error("Access denied in /feedback GET. No logged in user. bookingId={}", bookingId);
			model.addAttribute("error", "Please log in first.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		LOG.info("Feedback form opened by userId={} for bookingId={}", user.getUserId(), bookingId);
		
		Booking booking = bookingService.selectBookingById(bookingId); // Loads selected booking
		
		if (booking == null) { // Stops if booking does not exist
			LOG.error("Feedback form failed: booking not found. bookingId={}, userId={}", bookingId, user.getUserId());
			return "redirect:/mybookings";
		}
		
		if (!user.getUserId().equals(booking.getUserId())) { // Prevents access to another user's booking
			LOG.error("Feedback form denied: bookingId={} does not belong to userId={}", bookingId, user.getUserId());
			return "redirect:/mybookings";
		}
		
		if (!"PAID".equalsIgnoreCase(booking.getPaymentStatus())) { // Only paid bookings can leave feedback
			LOG.error("Feedback form denied: bookingId={} is not paid yet.", bookingId);
			return "redirect:/mybookings";
		}
		
		model.addAttribute("booking", booking); // Sends booking record to JSP
		model.addAttribute("bookingId", bookingId); // Sends bookingId to JSP
		model.addAttribute("feedbackForm", new FeedbackForm()); // Sends empty feedback form
		return "feedback";
	}
	
	@PostMapping("/feedback")
	public String processFeedback(@RequestParam("bookingId") Integer bookingId,
			@ModelAttribute("feedbackForm") FeedbackForm form,
			Model model,
			HttpSession session) {
		
		User user = (User) session.getAttribute("user"); // Gets current logged-in user
		if (user == null) { // Blocks access if no logged-in user
			LOG.error("Access denied in /feedback POST. No logged in user. bookingId={}", bookingId);
			model.addAttribute("error", "Please log in first.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		LOG.info("Feedback submission attempt by userId={} for bookingId={}", user.getUserId(), bookingId);
		
		Booking booking = bookingService.selectBookingById(bookingId); // Loads booking again for validation
		
		if (booking == null) { // Stops if booking not found
			LOG.error("Feedback submission failed: booking not found. bookingId={}, userId={}", bookingId, user.getUserId());
			return "redirect:/mybookings";
		}
		
		if (!user.getUserId().equals(booking.getUserId())) { // Prevents feedback on another user's booking
			LOG.error("Feedback submission denied: bookingId={} does not belong to userId={}", bookingId, user.getUserId());
			return "redirect:/mybookings";
		}
		
		if (!"PAID".equalsIgnoreCase(booking.getPaymentStatus())) { // Only paid bookings can submit feedback
			LOG.error("Feedback submission denied: bookingId={} is not paid yet.", bookingId);
			return "redirect:/mybookings";
		}
		
		String message = form.getMessage() == null ? "" : form.getMessage().trim(); // Gets and trims feedback message
		if (message.isBlank()) { // Checks if feedback message is empty
			LOG.error("Feedback submission failed for userId={}: message is blank. bookingId={}", user.getUserId(), bookingId);
			model.addAttribute("error", "Feedback message is required.");
			model.addAttribute("booking", booking);
			model.addAttribute("bookingId", bookingId);
			model.addAttribute("feedbackForm", form);
			return "feedback";
		}
		
		boolean res = feedbackService.createFeedback(
				user.getUserId(),
				booking.getBookingId(),
				booking.getPackageName(),
				user.getEmail(),
				user.getContactNo(),
				message,
				form.getRating()); // Saves feedback
		
		if (res) {
			LOG.info("Feedback submitted successfully by userId={} for bookingId={}", user.getUserId(), bookingId);
			model.addAttribute("message", "Feedback submitted successfully.");
			model.addAttribute("booking", booking);
			model.addAttribute("bookingId", bookingId);
			model.addAttribute("feedbackForm", new FeedbackForm()); // Resets form after success
			return "feedback";
		}
		
		LOG.error("Feedback submission failed for userId={} and bookingId={}", user.getUserId(), bookingId);
		model.addAttribute("error", "Feedback submission failed.");
		model.addAttribute("booking", booking);
		model.addAttribute("bookingId", bookingId);
		model.addAttribute("feedbackForm", form);
		return "feedback";
	}
	
	@GetMapping("/admin/feedback/edit")
	public String showEditFeedbackForm(@RequestParam("feedbackId") Integer feedbackId,
			Model model,
			HttpSession session) {
		
		User user = (User) session.getAttribute("user"); // Gets current session user
		if (user == null || (!"ADMIN".equalsIgnoreCase(user.getRole()) && !"SUPER_ADMIN".equalsIgnoreCase(user.getRole()))) { // Only ADMIN or SUPER_ADMIN allowed
			LOG.error("Access denied in /admin/feedback/edit GET. feedbackId={}", feedbackId);
			model.addAttribute("error", "Access denied.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		LOG.info("Admin feedback edit page opened by userId={} for feedbackId={}", user.getUserId(), feedbackId);
		
		Feedback rec = feedbackService.selectFeedbackById(feedbackId); // Loads selected feedback
		
		if (rec == null) { // Stops if feedback not found
			LOG.error("Admin feedback edit failed: feedback not found. feedbackId={}, userId={}", feedbackId, user.getUserId());
			return "redirect:/admin/feedback";
		}
		
		model.addAttribute("feedback", rec); // Sends feedback record to JSP
		return "admin/admin-edit-feedback";
	}

	@PostMapping("/admin/feedback/edit")
	public String processEditFeedback(@RequestParam("feedbackId") Integer feedbackId,
			@RequestParam("adminRemarks") String adminRemarks,
			@RequestParam("status") String status,
			Model model,
			HttpSession session) {
		
		User user = (User) session.getAttribute("user"); // Gets current session user
		if (user == null || (!"ADMIN".equalsIgnoreCase(user.getRole()) && !"SUPER_ADMIN".equalsIgnoreCase(user.getRole()))) { // Only ADMIN or SUPER_ADMIN allowed
			LOG.error("Access denied in /admin/feedback/edit POST. feedbackId={}", feedbackId);
			model.addAttribute("error", "Access denied.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		LOG.info("Admin feedback update attempt by userId={} for feedbackId={}", user.getUserId(), feedbackId);
		
		String remarks = adminRemarks == null ? "" : adminRemarks.trim(); // Gets and trims admin remarks
		String stat = status == null ? "" : status.trim(); // Gets and trims status
		
		if (remarks.isBlank() || stat.isBlank()) { // Checks if remarks or status is blank
			LOG.error("Admin feedback update failed for feedbackId={}: remarks or status is blank.", feedbackId);
			Feedback rec = feedbackService.selectFeedbackById(feedbackId);
			model.addAttribute("error", "Admin remarks and status are required.");
			model.addAttribute("feedback", rec);
			return "admin/admin-edit-feedback";
		}
		
		boolean res = feedbackService.updateFeedback(feedbackId, remarks, stat); // Updates feedback from admin side
		
		if (res) {
			LOG.info("Admin feedback updated successfully by userId={} for feedbackId={}", user.getUserId(), feedbackId);
			model.addAttribute("message", "Feedback updated successfully.");
			model.addAttribute("feedbackList", feedbackService.selectAllFeedback());
			return "admin/admin-feedback";
		}
		
		LOG.error("Admin feedback update failed by userId={} for feedbackId={}", user.getUserId(), feedbackId);
		Feedback rec = feedbackService.selectFeedbackById(feedbackId);
		model.addAttribute("error", "Failed to update feedback.");
		model.addAttribute("feedback", rec);
		return "admin/admin-edit-feedback";
	}
	
	
	@GetMapping("/myfeedbacks")
	public String showMyFeedbacks(Model model, HttpSession session) {
		User user = (User) session.getAttribute("user"); // Gets current logged-in user
		
		if (user == null) { // Blocks access if no logged-in user
			LOG.error("Access denied in /myfeedbacks. No logged in user.");
			model.addAttribute("error", "Please log in first.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		LOG.info("My feedbacks page opened by userId={}", user.getUserId());
		
		model.addAttribute("feedbackList", feedbackService.selectFeedbackByUserId(user.getUserId())); // Loads feedback of current user
		return "myfeedbacks";
	}
}