package org.fujitsu.training.codes.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.fujitsu.training.codes.model.data.Feedback;

public interface FeedbackMapper {

	@Insert("""
			insert into feedback(user_id, booking_id, package_name, email, contact_no, message, rating)
			values(#{userId}, #{bookingId}, #{packageName}, #{email}, #{contactNo}, #{message}, #{rating})
			""") // Inserts a new feedback record
	public Integer insertFeedback(
			@Param("userId") Integer userId, // User who submitted feedback
			@Param("bookingId") Integer bookingId, // Related booking ID
			@Param("packageName") String packageName, // Package name from booking
			@Param("email") String email, // User email
			@Param("contactNo") String contactNo, // User contact number
			@Param("message") String message, // Feedback message
			@Param("rating") Integer rating); // Feedback rating
	
	@Select("""
			select feedback_id as feedbackId,
				user_id as userId,
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
			""") // Gets all feedback records, newest first
	public List<Feedback> selectAllFeedback();
	
	@Select("""
			select feedback_id as feedbackId,
				user_id as userId,
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
			where feedback_id = #{feedbackId}
			""") // Gets one feedback record by feedback ID
	public Feedback selectFeedbackById(@Param("feedbackId") Integer feedbackId);
	
	@Update("""
			update feedback
			set admin_remarks = #{adminRemarks},
				status = #{status}
			where feedback_id = #{feedbackId}
			""") // Updates admin remarks and status of a feedback record
	public Integer updateFeedback(
			@Param("feedbackId") Integer feedbackId, // Feedback ID to update
			@Param("adminRemarks") String adminRemarks, // Admin remarks text
			@Param("status") String status); // New feedback status
	
	
	@Select("""
			select feedback_id as feedbackId,
				user_id as userId,
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
			where user_id = #{userId}
			order by feedback_id desc
			""") // Gets all feedback submitted by one user
	public List<Feedback> selectFeedbackByUserId(@Param("userId") Integer userId);

	
	//for pagination
	@Select("""
			select feedback_id as feedbackId,
				user_id as userId,
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
			limit #{limit} offset #{offset}
			""") // Gets feedback records per page for pagination
	public List<Feedback> selectFeedbackPage(
			@Param("limit") Integer limit, // Number of records per page
			@Param("offset") Integer offset); // Starting row for page

	@Select("""
			select count(*)
			from feedback
			""") // Counts all feedback records
	public Integer countAllFeedback();
	

}