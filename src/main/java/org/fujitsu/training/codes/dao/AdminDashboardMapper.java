package org.fujitsu.training.codes.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.fujitsu.training.codes.model.data.Booking;
import org.fujitsu.training.codes.model.data.Feedback;

public interface AdminDashboardMapper {

	@Select("select count(*) from users") // Counts all users
	public Integer countUsers();

	@Select("select count(*) from bookings") // Counts all bookings
	public Integer countBookings();

	@Select("select count(*) from payments") // Counts all payments
	public Integer countPayments();

	@Select("select count(*) from feedback") // Counts all feedback records
	public Integer countFeedback();

	@Select("select count(*) from packages") // Counts all packages
	public Integer countPackages();

	@Select("select count(*) from package_option") // Counts all package options
	public Integer countPackageOptions();

	@Select("""
			select booking_id as bookingId,
			       user_id as userId,
			       package_id as packageId,
			       booking_date as bookingDate,
			       comments,
			       status,
			       travel_date as travelDate,
			       traveler_count as travelerCount,
			       option_id as optionId
			from bookings
			order by booking_id desc
			limit 5
			""") // Gets the 5 most recent bookings
	public List<Booking> selectRecentBookings();

	@Select("""
			select feedback_id as feedbackId,
			       booking_id as bookingId,
			       package_name as packageName,
			       email,
			       contact_no as contactNo,
			       message,
			       rating,
			       feedback_date as feedbackDate,
			       admin_remarks as adminRemarks,
			       status
			from feedback
			order by feedback_id desc
			limit 5
			""") // Gets the 5 most recent feedback records
	public List<Feedback> selectRecentFeedback();
}