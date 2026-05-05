package org.fujitsu.training.codes.controller;

import java.time.LocalDate;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.fujitsu.training.codes.model.data.Booking;
import org.fujitsu.training.codes.model.data.NearbyPlace;
import org.fujitsu.training.codes.model.data.PackageOption;
import org.fujitsu.training.codes.model.data.TourPackage;
import org.fujitsu.training.codes.model.data.User;
import org.fujitsu.training.codes.model.data.WeatherInfo;
import org.fujitsu.training.codes.model.form.LoginForm;
import org.fujitsu.training.codes.service.BookingService;
import org.fujitsu.training.codes.service.NearbyPlaceService;
import org.fujitsu.training.codes.service.PackageOptionService;
import org.fujitsu.training.codes.service.PackageService;
import org.fujitsu.training.codes.service.WeatherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;

@Controller
public class BookingController {

	private static final Logger LOG = LogManager.getLogger(BookingController.class);

	@Autowired
	private BookingService bookingService;
	
	@Autowired
	private PackageService packageService;
	
	@Autowired
	private PackageOptionService packageOptionService;
	
	@Autowired
	private NearbyPlaceService nearbyPlaceService;
	
	@Autowired
	private WeatherService weatherService;

	@GetMapping("/book")
	public String showBookingPage(@RequestParam("packageId") Integer packageId,
			Model model,
			HttpSession session) {
		
		User user = (User) session.getAttribute("user");
		Integer userId = user != null ? user.getUserId() : null;
		
		LOG.info("Booking page opened. userId={}, packageId={}", userId, packageId);
		
		TourPackage pkg = packageService.selectPackageById(packageId);
		List<PackageOption> options = packageOptionService.selectOptionsByPackageId(packageId);
		List<NearbyPlace> nearbyPlaces = nearbyPlaceService.selectByPackageId(packageId);
		
		if (pkg == null) {
			LOG.error("Booking page failed: package not found. packageId={}, userId={}", packageId, userId);
			model.addAttribute("error", "Package not found.");
			return "home";
		}
		
		if (nearbyPlaces != null && pkg.getLatitude() != null && pkg.getLongitude() != null) {
		    for (NearbyPlace place : nearbyPlaces) {
		        if (place.getLatitude() != null && place.getLongitude() != null) {
		            double distance = org.fujitsu.training.codes.util.DistanceUtil.calculateDistanceKm(
		                    pkg.getLatitude(),
		                    pkg.getLongitude(),
		                    place.getLatitude(),
		                    place.getLongitude()
		            );
		            place.setDistanceKm(org.fujitsu.training.codes.util.DistanceUtil.roundTo2Decimals(distance));
		        }
		    }
		}
		
		WeatherInfo currentWeather = weatherService.getCurrentWeather(pkg.getLatitude(), pkg.getLongitude());
		
		model.addAttribute("rec", pkg);
		model.addAttribute("options", options);
		model.addAttribute("nearbyPlaces", nearbyPlaces);
		model.addAttribute("currentWeather", currentWeather);
		return "book";
	}
	
	@PostMapping("/book")
	public String processBooking(@RequestParam("packageId") Integer packageId,
			@RequestParam("optionId") Integer optionId,
			@RequestParam("travelDate") String travelDate,
			@RequestParam(value = "comments", required = false) String comments,
			Model model,
			HttpSession session) {
		
		User user = (User) session.getAttribute("user");
		if (user == null) {
			LOG.error("Access denied in /book POST. No logged in user. packageId={}, optionId={}", packageId, optionId);
			model.addAttribute("error", "Please log in first.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		LOG.info("Booking attempt by userId={} for packageId={}, optionId={}, travelDate={}",
				user.getUserId(), packageId, optionId, travelDate);
		
		TourPackage pkg = packageService.selectPackageById(packageId);
		List<PackageOption> options = packageOptionService.selectOptionsByPackageId(packageId);
		List<NearbyPlace> nearbyPlaces = nearbyPlaceService.selectByPackageId(packageId);
		WeatherInfo currentWeather = weatherService.getCurrentWeather(pkg == null ? null : pkg.getLatitude(),
				pkg == null ? null : pkg.getLongitude());
		PackageOption selectedOption = packageOptionService.selectOptionById(optionId);
		
		String note = comments == null ? "" : comments.trim();
		
		if (travelDate == null || travelDate.trim().isEmpty()) {
			LOG.error("Booking failed for userId={}: travel date is blank.", user.getUserId());
			model.addAttribute("error", "Travel date is required.");
			model.addAttribute("rec", pkg);
			model.addAttribute("options", options);
			model.addAttribute("nearbyPlaces", nearbyPlaces);
			model.addAttribute("currentWeather", currentWeather);
			return "book";
		}
		
		try {
			if (LocalDate.parse(travelDate).isBefore(LocalDate.now())) {
				LOG.error("Booking failed for userId={}: past travel date {}.", user.getUserId(), travelDate);
				model.addAttribute("error", "Travel date cannot be in the past.");
				model.addAttribute("rec", pkg);
				model.addAttribute("options", options);
				model.addAttribute("nearbyPlaces", nearbyPlaces);
				model.addAttribute("currentWeather", currentWeather);
				return "book";
			}
		} catch (Exception e) {
			LOG.error("Booking failed for userId={}: invalid travel date format {}.", user.getUserId(), travelDate, e);
			model.addAttribute("error", "Invalid travel date.");
			model.addAttribute("rec", pkg);
			model.addAttribute("options", options);
			model.addAttribute("nearbyPlaces", nearbyPlaces);
			model.addAttribute("currentWeather", currentWeather);
			return "book";
		}
		
		if (selectedOption == null) {
			LOG.error("Booking failed for userId={}: invalid package optionId={}.", user.getUserId(), optionId);
			model.addAttribute("error", "Please select a valid package option.");
			model.addAttribute("rec", pkg);
			model.addAttribute("options", options);
			model.addAttribute("nearbyPlaces", nearbyPlaces);
			model.addAttribute("currentWeather", currentWeather);
			return "book";
		}
		
		if (selectedOption.getAvailableSlots() == null || selectedOption.getAvailableSlots() <= 0) {
			LOG.error("Booking failed for userId={}: sold out optionId={}.", user.getUserId(), optionId);
			model.addAttribute("error", "Selected package option is already sold out.");
			model.addAttribute("rec", pkg);
			model.addAttribute("options", options);
			model.addAttribute("nearbyPlaces", nearbyPlaces);
			model.addAttribute("currentWeather", currentWeather);
			return "book";
		}
		
		boolean booked = bookingService.createBooking(
				user.getUserId(),
				packageId,
				optionId,
				note,
				travelDate);
		
		if (!booked) {
			LOG.error("Booking creation failed for userId={}, packageId={}, optionId={}",
					user.getUserId(), packageId, optionId);
			model.addAttribute("error", "Booking failed.");
			model.addAttribute("rec", pkg);
			model.addAttribute("options", options);
			model.addAttribute("nearbyPlaces", nearbyPlaces);
			model.addAttribute("currentWeather", currentWeather);
			return "book";
		}
		
		LOG.info("Booking created successfully with PENDING status for userId={}, packageId={}, optionId={}",
				user.getUserId(), packageId, optionId);
		
		return "redirect:/mybookings";
	}
	
	@GetMapping("/mybookings")
	public String showMyBookings(Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		
		if (user == null) {
			LOG.error("Access denied in /mybookings. No logged in user.");
			model.addAttribute("error", "Please log in first.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		LOG.info("My bookings page opened by userId={}", user.getUserId());
		List<Booking> records = bookingService.selectBookingsByUserId(user.getUserId());
		LOG.info("My bookings loaded for userId={}, recordCount={}", user.getUserId(), records.size());
		
		model.addAttribute("bookings", records);
		return "mybookings";
	}
	
	@PostMapping("/cancel-booking")
	public String cancelBooking(@RequestParam("bookingId") Integer bookingId,
			HttpSession session,
			Model model) {
		
		User user = (User) session.getAttribute("user");
		if (user == null) {
			LOG.error("Access denied in /cancel-booking. No logged in user. bookingId={}", bookingId);
			model.addAttribute("error", "Please log in first.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		LOG.info("Cancel booking attempt by userId={} for bookingId={}", user.getUserId(), bookingId);
		
		Booking booking = bookingService.selectBookingById(bookingId);
		
		if (booking == null) {
			LOG.error("Cancel booking failed: booking not found. bookingId={}, userId={}", bookingId, user.getUserId());
			return "redirect:/mybookings";
		}
		
		if (!user.getUserId().equals(booking.getUserId())) {
			LOG.error("Cancel booking denied: bookingId={} does not belong to userId={}", bookingId, user.getUserId());
			return "redirect:/mybookings";
		}
		
		if ("PAID".equalsIgnoreCase(booking.getPaymentStatus())) {
			LOG.error("Cancel booking denied: bookingId={} is already paid.", bookingId);
			return "redirect:/mybookings";
		}
		
		boolean wasConfirmed = "CONFIRMED".equalsIgnoreCase(booking.getStatus());
		
		boolean cancelled = bookingService.cancelBooking(bookingId);
		
		if (cancelled) {
			LOG.info("Booking cancelled successfully. bookingId={}, userId={}", bookingId, user.getUserId());
			
			if (wasConfirmed) {
				boolean slotIncreased = packageOptionService.increaseOptionSlots(booking.getOptionId());
				
				if (slotIncreased) {
					LOG.info("Package option slots increased successfully for optionId={}", booking.getOptionId());
				} else {
					LOG.error("Booking cancelled but failed to increase package option slots. optionId={}", booking.getOptionId());
				}
			}
		} else {
			LOG.error("Booking cancellation failed. bookingId={}, userId={}", bookingId, user.getUserId());
		}
		
		return "redirect:/mybookings";
	}
}