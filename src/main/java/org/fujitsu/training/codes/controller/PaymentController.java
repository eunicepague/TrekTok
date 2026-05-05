package org.fujitsu.training.codes.controller;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.fujitsu.training.codes.model.data.Booking;
import org.fujitsu.training.codes.model.data.Payment;
import org.fujitsu.training.codes.model.data.User;
import org.fujitsu.training.codes.model.form.LoginForm;
import org.fujitsu.training.codes.model.form.PaymentForm;
import org.fujitsu.training.codes.service.BookingService;
import org.fujitsu.training.codes.service.EmailService;
import org.fujitsu.training.codes.service.PackageOptionService;
import org.fujitsu.training.codes.service.PackageService;
import org.fujitsu.training.codes.service.PaymentService;
import org.fujitsu.training.codes.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;

@Controller
public class PaymentController {

	private static final Logger LOG = LogManager.getLogger(PaymentController.class);

	@Autowired
	private PaymentService paymentService;
	
	@Autowired
	private BookingService bookingService;
	
	@Autowired
	private PackageService packageService;
	
	@Autowired
	private PackageOptionService packageOptionService;

	@Autowired
	private UserService userService;

	@Autowired
	private EmailService emailService;

	@GetMapping("/pay")
	public String showPaymentForm(@RequestParam("bookingId") Integer bookingId,
			Model model,
			HttpSession session) {
		
		User user = (User) session.getAttribute("user");
		if (user == null) {
			LOG.error("Access denied in /pay GET. No logged in user. bookingId={}", bookingId);
			model.addAttribute("error", "Please log in first.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		LOG.info("Payment page opened by userId={} for bookingId={}", user.getUserId(), bookingId);
		
		Payment existingPayment = paymentService.selectPaymentByBookingId(bookingId);
		if (existingPayment != null) {
			LOG.error("Payment page blocked: payment already exists for bookingId={}, userId={}", bookingId, user.getUserId());
			return "redirect:/mybookings";
		}
		
		Booking booking = null;
		List<Booking> records = bookingService.selectBookingsByUserId(user.getUserId());
		for (Booking rec : records) {
			if (rec.getBookingId().equals(bookingId)) {
				booking = rec;
				break;
			}
		}
		
		if (booking == null) {
			LOG.error("Payment page failed: booking not found for bookingId={}, userId={}", bookingId, user.getUserId());
			model.addAttribute("error", "Booking not found.");
			return "redirect:/mybookings";
		}

		if (!"CONFIRMED".equalsIgnoreCase(booking.getStatus())) {
			LOG.error("Payment page blocked: booking is not confirmed. bookingId={}, status={}, userId={}",
					bookingId, booking.getStatus(), user.getUserId());
			return "redirect:/mybookings";
		}
		
		model.addAttribute("booking", booking);
		model.addAttribute("paymentForm", new PaymentForm(
				bookingId,
				"",
				"",
				"Credit Card",
				booking.getOptionPrice()
		));
		return "pay";
	}
	
	@PostMapping("/pay")
	public String processPayment(@ModelAttribute("paymentForm") PaymentForm form,
			Model model,
			HttpSession session) {
		
		User user = (User) session.getAttribute("user");
		if (user == null) {
			LOG.error("Access denied in /pay POST. No logged in user. bookingId={}", form.getBookingId());
			model.addAttribute("error", "Please log in first.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		Booking booking = null;
		List<Booking> records = bookingService.selectBookingsByUserId(user.getUserId());
		for (Booking rec : records) {
			if (rec.getBookingId().equals(form.getBookingId())) {
				booking = rec;
				break;
			}
		}
		
		if (booking == null) {
			LOG.error("Payment failed: booking not found for bookingId={}, userId={}", form.getBookingId(), user.getUserId());
			return "redirect:/mybookings";
		}

		if (!"CONFIRMED".equalsIgnoreCase(booking.getStatus())) {
			LOG.error("Payment blocked: booking is not confirmed. bookingId={}, status={}, userId={}",
					form.getBookingId(), booking.getStatus(), user.getUserId());
			return "redirect:/mybookings";
		}
		
		Double finalAmount = booking.getOptionPrice();
		
		LOG.info("Payment attempt by userId={} for bookingId={}, paymentType={}, amount={}",
				user.getUserId(), form.getBookingId(), form.getPaymentType(), finalAmount);
		
		if (form.getCardName() == null || form.getCardName().isBlank() ||
			form.getCardNumber() == null || form.getCardNumber().isBlank() ||
			form.getPaymentType() == null || form.getPaymentType().isBlank()) {
			
			LOG.error("Payment validation failed for userId={}, bookingId={}: required fields are blank.",
					user.getUserId(), form.getBookingId());
			
			model.addAttribute("booking", booking);
			form.setAmount(finalAmount);
			model.addAttribute("paymentForm", form);
			model.addAttribute("error", "All payment fields are required.");
			return "pay";
		}
		
		if (!form.getCardNumber().matches("\\d{16}")) {
			LOG.error("Payment validation failed for userId={}, bookingId={}: invalid card number format.",
					user.getUserId(), form.getBookingId());
			
			model.addAttribute("error", "Card number must be exactly 16 digits.");
			form.setAmount(finalAmount);
			model.addAttribute("paymentForm", form);
			model.addAttribute("booking", booking);
			return "pay";
		}
		
		boolean res = paymentService.createPayment(
				form.getBookingId(),
				form.getCardName(),
				form.getCardNumber(),
				form.getPaymentType(),
				finalAmount);
		
		if (res) {
			LOG.info("Payment created successfully for userId={}, bookingId={}", user.getUserId(), form.getBookingId());

			Payment savedPayment = paymentService.selectPaymentByBookingId(form.getBookingId());
			User fullUser = userService.selectUserById(user.getUserId());

			if (fullUser != null && fullUser.getEmail() != null && !fullUser.getEmail().trim().isEmpty() && savedPayment != null) {
				boolean emailSent = emailService.sendPaymentReceiptEmail(
						fullUser.getEmail(),
						fullUser.getFirstName(),
						booking.getPackageName(),
						booking.getOptionName(),
						booking.getTravelDate(),
						savedPayment.getAmount(),
						savedPayment.getPaymentDate(),
						savedPayment.getPaymentType(),
						booking.getBookingId()
				);

				if (emailSent) {
					LOG.info("Payment receipt email sent successfully to email={} for bookingId={}",
							fullUser.getEmail(), booking.getBookingId());
				} else {
					LOG.error("Payment created but receipt email sending failed for bookingId={}, email={}",
							booking.getBookingId(), fullUser.getEmail());
				}
			} else {
				LOG.error("Payment created but could not send receipt email. bookingId={}, userId={}",
						booking.getBookingId(), user.getUserId());
			}

			return "redirect:/mybookings";
		}
		
		LOG.error("Payment failed for userId={}, bookingId={}", user.getUserId(), form.getBookingId());
		
		model.addAttribute("booking", booking);
		form.setAmount(finalAmount);
		model.addAttribute("paymentForm", form);
		model.addAttribute("error", "Payment failed.");
		return "pay";
	}
}