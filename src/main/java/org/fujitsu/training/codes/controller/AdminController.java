package org.fujitsu.training.codes.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.fujitsu.training.codes.model.data.Booking;
import org.fujitsu.training.codes.model.data.Feedback;
import org.fujitsu.training.codes.model.data.PackageOption;
import org.fujitsu.training.codes.model.data.Payment;
import org.fujitsu.training.codes.model.data.TourPackage;
import org.fujitsu.training.codes.model.data.User;
import org.fujitsu.training.codes.model.form.FeedbackUpdateForm;
import org.fujitsu.training.codes.model.form.LoginForm;
import org.fujitsu.training.codes.model.form.PackageForm;
import org.fujitsu.training.codes.model.form.PackageOptionForm;
import org.fujitsu.training.codes.service.AdminDashboardService;
import org.fujitsu.training.codes.service.BookingService;
import org.fujitsu.training.codes.service.EmailService;
import org.fujitsu.training.codes.service.FeedbackService;
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
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {

	private static final Logger LOG = LogManager.getLogger(AdminController.class);

	@Autowired
	private UserService userService;
	
	@Autowired
	private BookingService bookingService;
	
	@Autowired
	private PaymentService paymentService;
	
	@Autowired
	private FeedbackService feedbackService;
	
	@Autowired
	private PackageService packageService;
	
	@Autowired
	private PackageOptionService packageOptionService;
	
	@Autowired
	private AdminDashboardService adminDashboardService;

	@Autowired
	private EmailService emailService;
	
	private boolean isAdminAuthorized(User user) {
		return user != null
				&& "ACTIVE".equalsIgnoreCase(user.getAccountStatus())
				&& ("ADMIN".equalsIgnoreCase(user.getRole())
						|| "SUPER_ADMIN".equalsIgnoreCase(user.getRole()));
	}
	
	private boolean isSuperAdmin(User user) {
		return user != null
				&& "ACTIVE".equalsIgnoreCase(user.getAccountStatus())
				&& "SUPER_ADMIN".equalsIgnoreCase(user.getRole());
	}

	@GetMapping("/admin")
	public String showAdminHome(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		
		if (!isAdminAuthorized(user)) {
			LOG.error("Access denied in /admin. Session user is not authorized.");
			model.addAttribute("error", "Access denied.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		LOG.info("Admin dashboard opened by userId={}, role={}", user.getUserId(), user.getRole());
		
		model.addAttribute("totalUsers", adminDashboardService.countUsers());
		model.addAttribute("totalBookings", adminDashboardService.countBookings());
		model.addAttribute("totalPayments", adminDashboardService.countPayments());
		model.addAttribute("totalFeedback", adminDashboardService.countFeedback());
		model.addAttribute("totalPackages", adminDashboardService.countPackages());
		model.addAttribute("totalPackageOptions", adminDashboardService.countPackageOptions());

		model.addAttribute("recentBookings", adminDashboardService.selectRecentBookings());
		model.addAttribute("recentFeedback", adminDashboardService.selectRecentFeedback());
		
		return "admin/admin-home";
	}
	
	@GetMapping("/admin/users")
	public String showAllUsers(Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		
		if (!isAdminAuthorized(user)) {
			LOG.error("Access denied in /admin/users. Session user is not authorized.");
			model.addAttribute("error", "Access denied.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		LOG.info("User list viewed by admin userId={}", user.getUserId());
		
		List<User> records = userService.selectAllUsers();
		model.addAttribute("users", records);
		model.addAttribute("sessionUser", user);
		return "admin/admin-users";
	}
	
	@GetMapping("/admin/bookings")
	public String showAllBookings(@RequestParam(value = "page", defaultValue = "1") Integer page,
			Model model,
			HttpSession session) {
		User user = (User) session.getAttribute("user");
		
		if (!isAdminAuthorized(user)) {
			LOG.error("Access denied in /admin/bookings. Session user is not authorized.");
			model.addAttribute("error", "Access denied.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		int pageSize = 10;
		int currentPage = page == null || page < 1 ? 1 : page;
		int offset = (currentPage - 1) * pageSize;
		
		LOG.info("Booking list viewed by admin userId={}, page={}", user.getUserId(), currentPage);
		
		List<Booking> records = bookingService.selectBookingsPage(pageSize, offset);
		int totalRecords = bookingService.countAllBookings();
		int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
		
		model.addAttribute("bookings", records);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("totalPages", totalPages);
		
		return "admin/admin-bookings";
	}

	@PostMapping("/admin/bookings/status")
	public String updateBookingStatus(@RequestParam("bookingId") Integer bookingId,
			@RequestParam("status") String status,
			HttpSession session,
			Model model) {
		
		User user = (User) session.getAttribute("user");
		
		if (!isAdminAuthorized(user)) {
			LOG.error("Access denied in /admin/bookings/status. Session user is not authorized.");
			model.addAttribute("error", "Access denied.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		if (!"CONFIRMED".equalsIgnoreCase(status) && !"REJECTED".equalsIgnoreCase(status)) {
			LOG.error("Invalid booking status update attempt. bookingId={}, status={}", bookingId, status);
			return "redirect:/admin/bookings";
		}
		
		Booking booking = bookingService.selectBookingById(bookingId);
		if (booking == null) {
			LOG.error("Booking not found for status update. bookingId={}", bookingId);
			return "redirect:/admin/bookings";
		}
		
		boolean ok = bookingService.updateBookingStatus(bookingId, status);
		
		if (ok) {
			LOG.info("Booking status updated successfully by admin userId={}. bookingId={}, status={}",
					user.getUserId(), bookingId, status);
			
			if ("CONFIRMED".equalsIgnoreCase(status)) {
				boolean slotUpdated = packageOptionService.decreaseOptionSlots(booking.getOptionId());
				
				if (slotUpdated) {
					LOG.info("Package option slots decreased successfully for optionId={}", booking.getOptionId());
				} else {
					LOG.error("Booking confirmed but failed to decrease package option slots. optionId={}",
							booking.getOptionId());
				}
			}

			User bookingUser = userService.selectUserById(booking.getUserId());
			if (bookingUser != null && bookingUser.getEmail() != null && !bookingUser.getEmail().trim().isEmpty()) {
				boolean emailSent = emailService.sendBookingStatusEmail(
						bookingUser.getEmail(),
						bookingUser.getFirstName(),
						booking.getPackageName(),
						booking.getOptionName(),
						booking.getTravelDate(),
						status
				);

				if (emailSent) {
					LOG.info("Booking status email sent successfully to email={} for bookingId={}",
							bookingUser.getEmail(), bookingId);
				} else {
					LOG.error("Booking status updated but email sending failed for bookingId={}, email={}",
							bookingId, bookingUser.getEmail());
				}
			} else {
				LOG.error("Booking status updated but user email not found for bookingId={}, userId={}",
						bookingId, booking.getUserId());
			}
		} else {
			LOG.error("Booking status update failed by admin userId={}. bookingId={}, status={}",
					user.getUserId(), bookingId, status);
		}
		
		return "redirect:/admin/bookings";
	}
	
	@GetMapping("/admin/payments")
	public String showAllPayments(@RequestParam(value = "page", defaultValue = "1") Integer page,
			Model model,
			HttpSession session) {
		User user = (User) session.getAttribute("user");
		
		if (!isAdminAuthorized(user)) {
			LOG.error("Access denied in /admin/payments. Session user is not authorized.");
			model.addAttribute("error", "Access denied.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		int pageSize = 10;
		int currentPage = page == null || page < 1 ? 1 : page;
		int offset = (currentPage - 1) * pageSize;
		
		LOG.info("Payment list viewed by admin userId={}, page={}", user.getUserId(), currentPage);
		
		List<Payment> records = paymentService.selectPaymentsPage(pageSize, offset);
		int totalRecords = paymentService.countAllPayments();
		int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
		
		model.addAttribute("payments", records);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("totalPages", totalPages);
		
		return "admin/admin-payments";
	}
	
	@GetMapping("/admin/feedback")
	public String showAllFeedback(@RequestParam(value = "page", defaultValue = "1") Integer page,
			Model model,
			HttpSession session) {
		User user = (User) session.getAttribute("user");
		
		if (!isAdminAuthorized(user)) {
			LOG.error("Access denied in /admin/feedback. Session user is not authorized.");
			model.addAttribute("error", "Access denied.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		int pageSize = 10;
		int currentPage = page == null || page < 1 ? 1 : page;
		int offset = (currentPage - 1) * pageSize;
		
		LOG.info("Feedback list viewed by admin userId={}, page={}", user.getUserId(), currentPage);
		
		List<Feedback> records = feedbackService.selectFeedbackPage(pageSize, offset);
		int totalRecords = feedbackService.countAllFeedback();
		int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
		
		model.addAttribute("feedbackList", records);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("totalPages", totalPages);
		
		return "admin/admin-feedback";
	}
	
	@PostMapping("/admin/feedback/update")
	public String updateFeedback(@ModelAttribute FeedbackUpdateForm form,
			HttpSession session,
			Model model) {
		User user = (User) session.getAttribute("user");
		
		if (!isAdminAuthorized(user)) {
			LOG.error("Access denied in /admin/feedback/update. Session user is not authorized.");
			model.addAttribute("error", "Access denied.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		LOG.info("Feedback update attempt by admin userId={} for feedbackId={}", user.getUserId(), form.getFeedbackId());
		
		feedbackService.updateFeedback(
				form.getFeedbackId(),
				form.getAdminRemarks(),
				form.getStatus());
		
		LOG.info("Feedback updated successfully by admin userId={} for feedbackId={}", user.getUserId(), form.getFeedbackId());
		
		return "redirect:/admin/feedback";
	}
	
	@PostMapping("/admin/users/role")
	public String updateUserRole(@RequestParam("userId") Integer userId,
			@RequestParam("role") String role,
			HttpSession session,
			Model model) {
		
		User user = (User) session.getAttribute("user");
		
		if (!isSuperAdmin(user)) {
			LOG.error("Access denied in /admin/users/role. Only SUPER_ADMIN allowed.");
			model.addAttribute("error", "Only SUPER_ADMIN can update user roles.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		if (user.getUserId().equals(userId)) {
			LOG.error("SUPER_ADMIN userId={} attempted to change own role.", user.getUserId());
			return "redirect:/admin/users";
		}
		
		if ("SUPER_ADMIN".equalsIgnoreCase(role)) {
			LOG.error("SUPER_ADMIN userId={} attempted to assign SUPER_ADMIN role through UI to userId={}.", user.getUserId(), userId);
			return "redirect:/admin/users";
		}
		
		LOG.info("SUPER_ADMIN userId={} updating role of userId={} to {}", user.getUserId(), userId, role);
		
		userService.updateUserRole(userId, role);
		return "redirect:/admin/users";
	}

	@PostMapping("/admin/users/status")
	public String updateAccountStatus(@RequestParam("userId") Integer userId,
			@RequestParam("accountStatus") String accountStatus,
			HttpSession session,
			Model model) {
		
		User user = (User) session.getAttribute("user");
		
		if (!isSuperAdmin(user)) {
			LOG.error("Access denied in /admin/users/status. Only SUPER_ADMIN allowed.");
			model.addAttribute("error", "Only SUPER_ADMIN can update account status.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		if (user.getUserId().equals(userId)) {
			LOG.error("SUPER_ADMIN userId={} attempted to change own account status.", user.getUserId());
			return "redirect:/admin/users";
		}
		
		LOG.info("SUPER_ADMIN userId={} updating account status of userId={} to {}", user.getUserId(), userId, accountStatus);
		
		userService.updateAccountStatus(userId, accountStatus);
		return "redirect:/admin/users";
	}
	
	@GetMapping("/admin/packages")
	public String showAllPackages(@RequestParam(value = "page", defaultValue = "1") Integer page,
			Model model,
			HttpSession session) {
		User user = (User) session.getAttribute("user");
		
		if (!isAdminAuthorized(user)) {
			LOG.error("Access denied in /admin/packages. Session user is not authorized.");
			model.addAttribute("error", "Access denied.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		int pageSize = 10;
		int currentPage = page == null || page < 1 ? 1 : page;
		int offset = (currentPage - 1) * pageSize;
		
		LOG.info("Package list viewed by admin userId={}, page={}", user.getUserId(), currentPage);
		
		List<TourPackage> records = packageService.selectPackagesPage(pageSize, offset);

		for (TourPackage rec : records) {
			int optionCount = packageOptionService.countOptionsByPackageId(rec.getPackageId());
			rec.setHasOptions(optionCount > 0);
		}

		int totalRecords = packageService.countAllPackages();
		int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

		model.addAttribute("packages", records);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("totalPages", totalPages);

		Object success = session.getAttribute("success");
		if (success != null) {
			model.addAttribute("success", success.toString());
			session.removeAttribute("success");
		}
		
		return "admin/admin-packages";
	}

	@GetMapping("/admin/packages/add")
	public String showAddPackageForm(Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		
		if (!isAdminAuthorized(user)) {
			LOG.error("Access denied in /admin/packages/add GET. Session user is not authorized.");
			model.addAttribute("error", "Access denied.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		LOG.info("Add package form opened by admin userId={}", user.getUserId());
		
		model.addAttribute("packageForm", new PackageForm());
		return "admin/admin-add-package";
	}

	@PostMapping("/admin/packages/add")
	public String addPackage(@ModelAttribute PackageForm form,
			@RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
			HttpSession session,
			Model model) {
		
		User user = (User) session.getAttribute("user");
		
		if (!isAdminAuthorized(user)) {
			LOG.error("Access denied in /admin/packages/add POST. Session user is not authorized.");
			model.addAttribute("error", "Access denied.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		LOG.info("Admin userId={} is attempting to add package: {}", user.getUserId(), form.getPackageName());
		
		if (form.getPackageName() == null || form.getPackageName().trim().isEmpty()
				|| form.getDestination() == null || form.getDestination().trim().isEmpty()
				|| form.getDescription() == null || form.getDescription().trim().isEmpty()
				|| form.getPrice() == null || form.getPrice() <= 0
				|| form.getDuration() == null || form.getDuration().trim().isEmpty()
				|| form.getPackageType() == null || form.getPackageType().trim().isEmpty()) {
			
			LOG.error("Add package failed for admin userId={}: invalid form input.", user.getUserId());
			model.addAttribute("error", "Please fill in all required fields correctly.");
			model.addAttribute("packageForm", form);
			return "admin/admin-add-package";
		}
		
		String imageName = null;
		
		if (imageFile != null && !imageFile.isEmpty()) {
			String originalFilename = imageFile.getOriginalFilename();
			
			if (originalFilename != null) {
				String lowerName = originalFilename.toLowerCase();
				boolean validImage = lowerName.endsWith(".jpg")
						|| lowerName.endsWith(".jpeg")
						|| lowerName.endsWith(".png")
						|| lowerName.endsWith(".webp");
				
				if (!validImage) {
					LOG.error("Add package failed for admin userId={}: invalid image file type {}.", user.getUserId(), originalFilename);
					model.addAttribute("error", "Only JPG, JPEG, PNG, and WEBP files are allowed.");
					model.addAttribute("packageForm", form);
					return "admin/admin-add-package";
				}
				
				imageName = new File(originalFilename).getName();
				
				 try {
				        String uploadPath = session.getServletContext()
				                .getRealPath("/resources/images/packages/");

				        File uploadDir = new File(uploadPath);
				        if (!uploadDir.exists()) {
				            uploadDir.mkdirs();
				        }

				        File destination = new File(uploadDir, imageName);
				        imageFile.transferTo(destination);

				    } catch (IOException e) {
				        e.printStackTrace();
				        model.addAttribute("error", "Failed to upload image.");
				        model.addAttribute("packageForm", form);
				        return "admin/admin-add-package";
				    }
			}
		}
		
		TourPackage rec = new TourPackage();
		rec.setPackageName(form.getPackageName());
		rec.setDestination(form.getDestination());
		rec.setDescription(form.getDescription());
		rec.setPrice(form.getPrice());
		rec.setDuration(form.getDuration());
		rec.setImageName(imageName);
		rec.setAvailableSlots(0);
		rec.setWeatherInfo(form.getWeatherInfo());
		rec.setLatitude(form.getLatitude());
		rec.setLongitude(form.getLongitude());
		rec.setPackageType(form.getPackageType());
		
		boolean ok = packageService.insertPackage(rec);
		
		if (!ok) {
			LOG.error("Package insert failed for package {} by admin userId={}", form.getPackageName(), user.getUserId());
			model.addAttribute("error", "Failed to add package.");
			model.addAttribute("packageForm", form);
			return "admin/admin-add-package";
		}
		
		LOG.info("Package added successfully by admin userId={}: {}", user.getUserId(), form.getPackageName());
		
		session.setAttribute("success", "Package added successfully.");
		return "redirect:/admin/packages";
	}
	
	@GetMapping("/admin/packages/edit")
	public String showEditPackageForm(@RequestParam("packageId") Integer packageId,
			Model model,
			HttpSession session) {
		
		User user = (User) session.getAttribute("user");
		
		if (!isAdminAuthorized(user)) {
			LOG.error("Access denied in /admin/packages/edit GET. Session user is not authorized.");
			model.addAttribute("error", "Access denied.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		LOG.info("Edit package form opened by admin userId={} for packageId={}", user.getUserId(), packageId);
		
		TourPackage rec = packageService.selectPackageById(packageId);
		
		if (rec == null) {
			LOG.error("Package not found for editing. packageId={}", packageId);
			return "redirect:/admin/packages";
		}
		
		PackageForm form = new PackageForm();
		form.setPackageId(rec.getPackageId());
		form.setPackageName(rec.getPackageName());
		form.setDestination(rec.getDestination());
		form.setDescription(rec.getDescription());
		form.setPrice(rec.getPrice());
		form.setDuration(rec.getDuration());
		form.setImageName(rec.getImageName());
		form.setWeatherInfo(rec.getWeatherInfo());
		form.setLatitude(rec.getLatitude());
		form.setLongitude(rec.getLongitude());
		form.setPackageType(rec.getPackageType());
		
		model.addAttribute("packageForm", form);
		return "admin/admin-edit-package";
	}

	@PostMapping("/admin/packages/edit")
	public String editPackage(@ModelAttribute PackageForm form,
			@RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
			Model model,
			HttpSession session) {
		
		User user = (User) session.getAttribute("user");
		
		if (!isAdminAuthorized(user)) {
			LOG.error("Access denied in /admin/packages/edit POST. Session user is not authorized.");
			model.addAttribute("error", "Access denied.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		LOG.info("Admin userId={} is attempting to update packageId={}", user.getUserId(), form.getPackageId());
		
		if (form.getPackageId() == null
				|| form.getPackageName() == null || form.getPackageName().trim().isEmpty()
				|| form.getDestination() == null || form.getDestination().trim().isEmpty()
				|| form.getDescription() == null || form.getDescription().trim().isEmpty()
				|| form.getPrice() == null || form.getPrice() <= 0
				|| form.getDuration() == null || form.getDuration().trim().isEmpty()
				|| form.getPackageType() == null || form.getPackageType().trim().isEmpty()) {
			
			LOG.error("Update package failed for admin userId={}: invalid form input.", user.getUserId());
			model.addAttribute("error", "Please fill in all required fields correctly.");
			model.addAttribute("packageForm", form);
			return "admin/admin-edit-package";
		}
		
		String imageName = form.getImageName();
		
		if (imageFile != null && !imageFile.isEmpty()) {
			String originalFilename = imageFile.getOriginalFilename();

			if (originalFilename != null) {
				String lowerName = originalFilename.toLowerCase();
				boolean validImage = lowerName.endsWith(".jpg")
						|| lowerName.endsWith(".jpeg")
						|| lowerName.endsWith(".png")
						|| lowerName.endsWith(".webp");
				
				if (!validImage) {
					model.addAttribute("error", "Only JPG, JPEG, PNG, and WEBP files are allowed.");
					model.addAttribute("packageForm", form);
					return "admin/admin-edit-package";
				}
				
				imageName = new File(originalFilename).getName();
				
				try {
					String uploadPath = session.getServletContext()
							.getRealPath("/resources/images/packages/");
					
					File uploadDir = new File(uploadPath);
					if (!uploadDir.exists()) {
						uploadDir.mkdirs();
					}
					
					File destination = new File(uploadDir, imageName);
					imageFile.transferTo(destination);
				} catch (IOException e) {
					e.printStackTrace();
					model.addAttribute("error", "Failed to upload image.");
					model.addAttribute("packageForm", form);
					return "admin/admin-edit-package";
				}
			}
		}
		
		TourPackage rec = new TourPackage();
		rec.setPackageId(form.getPackageId());
		rec.setPackageName(form.getPackageName());
		rec.setDestination(form.getDestination());
		rec.setDescription(form.getDescription());
		rec.setPrice(form.getPrice());
		rec.setDuration(form.getDuration());
		rec.setImageName(imageName);
		rec.setWeatherInfo(form.getWeatherInfo());
		rec.setLatitude(form.getLatitude());
		rec.setLongitude(form.getLongitude());
		rec.setPackageType(form.getPackageType());
		
		TourPackage oldRec = packageService.selectPackageById(form.getPackageId());
		if (oldRec != null) {
			rec.setAvailableSlots(oldRec.getAvailableSlots());
		} else {
			rec.setAvailableSlots(0);
		}
		
		boolean ok = packageService.updatePackage(rec);
		
		if (!ok) {
			LOG.error("Package update failed for packageId={} by admin userId={}", form.getPackageId(), user.getUserId());
			model.addAttribute("error", "Failed to update package.");
			model.addAttribute("packageForm", form);
			return "admin/admin-edit-package";
		}
		
		LOG.info("Package updated successfully by admin userId={} for packageId={}", user.getUserId(), form.getPackageId());
		
		session.setAttribute("success", "Package updated successfully.");
		
		return "redirect:/admin/packages";
	}

	@PostMapping("/admin/packages/delete")
	public String deletePackage(@RequestParam("packageId") Integer packageId,
			HttpSession session,
			Model model) {
		
		User user = (User) session.getAttribute("user");
		
		if (!isAdminAuthorized(user)) {
			LOG.error("Access denied in /admin/packages/delete. Session user is not authorized.");
			model.addAttribute("error", "Access denied.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		LOG.info("Admin userId={} is attempting to delete packageId={}", user.getUserId(), packageId);
		
		int optionCount = packageOptionService.countOptionsByPackageId(packageId);
		
		if (optionCount > 0) {
			LOG.error("Delete package blocked for packageId={} because it still has {} package options.", packageId, optionCount);
			model.addAttribute("error", "Cannot delete package because it still has package options. Please delete its package options first.");
			model.addAttribute("packages", packageService.selectAllPackages());
			return "admin/admin-packages";
		}
		
		boolean ok = packageService.deletePackage(packageId);
		
		if (!ok) {
			LOG.error("Package delete failed for packageId={} by admin userId={}", packageId, user.getUserId());
			model.addAttribute("error", "Failed to delete package.");
			model.addAttribute("packages", packageService.selectAllPackages());
			return "admin/admin-packages";
		}
		
		LOG.info("Package deleted successfully by admin userId={} for packageId={}", user.getUserId(), packageId);
		
		session.setAttribute("success", "Package deleted successfully.");
		
		return "redirect:/admin/packages";
	}
	
	@GetMapping("/admin/package-options")
	public String showAllPackageOptions(@RequestParam(value = "page", defaultValue = "1") Integer page,
			Model model,
			HttpSession session) {
		User user = (User) session.getAttribute("user");
		
		if (!isAdminAuthorized(user)) {
			LOG.error("Access denied in /admin/package-options. Session user is not authorized.");
			model.addAttribute("error", "Access denied.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		int pageSize = 10;
		int currentPage = page == null || page < 1 ? 1 : page;
		int offset = (currentPage - 1) * pageSize;
		
		LOG.info("Package option list viewed by admin userId={}, page={}", user.getUserId(), currentPage);
		
		List<PackageOption> records = packageOptionService.selectPackageOptionsPage(pageSize, offset);

		for (PackageOption rec : records) {
			int bookingCount = bookingService.countBookingsByOptionId(rec.getOptionId());
			rec.setUsedInBookings(bookingCount > 0);
		}
		
		List<TourPackage> packages = packageService.selectAllPackages();
		int totalRecords = packageOptionService.countAllPackageOptions();
		int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
		
		model.addAttribute("packageOptions", records);
		model.addAttribute("packages", packages);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("totalPages", totalPages);

		Object success = session.getAttribute("success");
		if (success != null) {
			model.addAttribute("success", success.toString());
			session.removeAttribute("success");
		}
		
		return "admin/admin-package-options";
	}

	@GetMapping("/admin/package-options/add")
	public String showAddPackageOptionForm(Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		
		if (!isAdminAuthorized(user)) {
			LOG.error("Access denied in /admin/package-options/add GET. Session user is not authorized.");
			model.addAttribute("error", "Access denied.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		LOG.info("Add package option form opened by admin userId={}", user.getUserId());
		
		model.addAttribute("packageOptionForm", new PackageOptionForm());
		model.addAttribute("packages", packageService.selectAllPackages());
		return "admin/admin-add-package-option";
	}

	@PostMapping("/admin/package-options/add")
	public String addPackageOption(@ModelAttribute PackageOptionForm form,
			HttpSession session,
			Model model) {
		
		User user = (User) session.getAttribute("user");
		
		if (!isAdminAuthorized(user)) {
			LOG.error("Access denied in /admin/package-options/add POST. Session user is not authorized.");
			model.addAttribute("error", "Access denied.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		LOG.info("Admin userId={} is attempting to add package option: {}", user.getUserId(), form.getOptionName());
		
		if (form.getPackageId() == null
				|| form.getOptionName() == null || form.getOptionName().trim().isEmpty()
				|| form.getDescription() == null || form.getDescription().trim().isEmpty()
				|| form.getPrice() == null || form.getPrice() <= 0
				|| form.getMaxPax() == null || form.getMaxPax() <= 0
				|| form.getAvailableSlots() == null || form.getAvailableSlots() < 0) {
			
			LOG.error("Add package option failed for admin userId={}: invalid form input.", user.getUserId());
			model.addAttribute("error", "Please fill in all fields correctly.");
			model.addAttribute("packageOptionForm", form);
			model.addAttribute("packages", packageService.selectAllPackages());
			return "admin/admin-add-package-option";
		}
		
		PackageOption rec = new PackageOption();
		rec.setPackageId(form.getPackageId());
		rec.setOptionName(form.getOptionName());
		rec.setDescription(form.getDescription());
		rec.setPrice(form.getPrice());
		rec.setMaxPax(form.getMaxPax());
		rec.setAvailableSlots(form.getAvailableSlots());
		
		boolean ok = packageOptionService.insertPackageOption(rec);
		
		if (!ok) {
			LOG.error("Package option insert failed for optionName={} by admin userId={}", form.getOptionName(), user.getUserId());
			model.addAttribute("error", "Failed to add package option.");
			model.addAttribute("packageOptionForm", form);
			model.addAttribute("packages", packageService.selectAllPackages());
			return "admin/admin-add-package-option";
		}
		
		LOG.info("Package option added successfully by admin userId={}: {}", user.getUserId(), form.getOptionName());
		
		session.setAttribute("success", "Package option added successfully.");
		
		return "redirect:/admin/package-options";
	}
	
	@GetMapping("/admin/package-options/edit")
	public String showEditPackageOptionForm(@RequestParam("optionId") Integer optionId,
			Model model,
			HttpSession session) {
		
		User user = (User) session.getAttribute("user");
		
		if (!isAdminAuthorized(user)) {
			LOG.error("Access denied in /admin/package-options/edit GET. Session user is not authorized.");
			model.addAttribute("error", "Access denied.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		LOG.info("Edit package option form opened by admin userId={} for optionId={}", user.getUserId(), optionId);
		
		PackageOption rec = packageOptionService.selectOptionById(optionId);
		
		if (rec == null) {
			LOG.error("Package option not found for editing. optionId={}", optionId);
			return "redirect:/admin/package-options";
		}
		
		PackageOptionForm form = new PackageOptionForm();
		form.setOptionId(rec.getOptionId());
		form.setPackageId(rec.getPackageId());
		form.setOptionName(rec.getOptionName());
		form.setDescription(rec.getDescription());
		form.setPrice(rec.getPrice());
		form.setMaxPax(rec.getMaxPax());
		form.setAvailableSlots(rec.getAvailableSlots());
		
		model.addAttribute("packageOptionForm", form);
		model.addAttribute("packages", packageService.selectAllPackages());
		return "admin/admin-edit-package-option";
	}

	@PostMapping("/admin/package-options/edit")
	public String editPackageOption(@ModelAttribute PackageOptionForm form,
			Model model,
			HttpSession session) {
		
		User user = (User) session.getAttribute("user");
		
		if (!isAdminAuthorized(user)) {
			LOG.error("Access denied in /admin/package-options/edit POST. Session user is not authorized.");
			model.addAttribute("error", "Access denied.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		LOG.info("Admin userId={} is attempting to update package optionId={}", user.getUserId(), form.getOptionId());
		
		if (form.getOptionId() == null
				|| form.getPackageId() == null
				|| form.getOptionName() == null || form.getOptionName().trim().isEmpty()
				|| form.getDescription() == null || form.getDescription().trim().isEmpty()
				|| form.getPrice() == null || form.getPrice() <= 0
				|| form.getMaxPax() == null || form.getMaxPax() <= 0
				|| form.getAvailableSlots() == null || form.getAvailableSlots() < 0) {
			
			LOG.error("Update package option failed for admin userId={}: invalid form input.", user.getUserId());
			model.addAttribute("error", "Please fill in all fields correctly.");
			model.addAttribute("packageOptionForm", form);
			model.addAttribute("packages", packageService.selectAllPackages());
			return "admin/admin-edit-package-option";
		}
		
		PackageOption rec = new PackageOption();
		rec.setOptionId(form.getOptionId());
		rec.setPackageId(form.getPackageId());
		rec.setOptionName(form.getOptionName());
		rec.setDescription(form.getDescription());
		rec.setPrice(form.getPrice());
		rec.setMaxPax(form.getMaxPax());
		rec.setAvailableSlots(form.getAvailableSlots());
		
		boolean ok = packageOptionService.updatePackageOption(rec);
		
		if (!ok) {
			LOG.error("Package option update failed for optionId={} by admin userId={}", form.getOptionId(), user.getUserId());
			model.addAttribute("error", "Failed to update package option.");
			model.addAttribute("packageOptionForm", form);
			model.addAttribute("packages", packageService.selectAllPackages());
			return "admin/admin-edit-package-option";
		}
		
		LOG.info("Package option updated successfully by admin userId={} for optionId={}", user.getUserId(), form.getOptionId());
		
		session.setAttribute("success", "Package option updated successfully.");
		return "redirect:/admin/package-options";
	}

	@PostMapping("/admin/package-options/delete")
	public String deletePackageOption(@RequestParam("optionId") Integer optionId,
			HttpSession session,
			Model model) {
		
		User user = (User) session.getAttribute("user");
		
		if (!isAdminAuthorized(user)) {
			LOG.error("Access denied in /admin/package-options/delete. Session user is not authorized.");
			model.addAttribute("error", "Access denied.");
			model.addAttribute("loginForm", new LoginForm());
			return "login";
		}
		
		LOG.info("Admin userId={} is attempting to delete package optionId={}", user.getUserId(), optionId);
		
		int bookingCount = bookingService.countBookingsByOptionId(optionId);
		
		if (bookingCount > 0) {
			LOG.error("Delete package option blocked for optionId={} because it is already used in {} bookings.", optionId, bookingCount);
			model.addAttribute("error", "Cannot delete package option because it is already used in bookings.");
			model.addAttribute("packageOptions", packageOptionService.selectAllPackageOptions());
			return "admin/admin-package-options";
		}
		
		boolean ok = packageOptionService.deletePackageOption(optionId);
		
		if (!ok) {
			LOG.error("Package option delete failed for optionId={} by admin userId={}", optionId, user.getUserId());
			model.addAttribute("error", "Failed to delete package option.");
			model.addAttribute("packageOptions", packageOptionService.selectAllPackageOptions());
			return "admin/admin-package-options";
		}
		
		LOG.info("Package option deleted successfully by admin userId={} for optionId={}", user.getUserId(), optionId);
		
		session.setAttribute("success", "Package option deleted successfully.");
		
		return "redirect:/admin/package-options";
	}
}