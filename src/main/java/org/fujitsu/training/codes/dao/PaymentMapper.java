package org.fujitsu.training.codes.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.fujitsu.training.codes.model.data.Payment;

public interface PaymentMapper {

	@Insert("""
			insert into payments(booking_id, card_name, card_number, payment_type, amount, status)
			values(#{bookingId}, #{cardName}, #{cardNumber}, #{paymentType}, #{amount}, 'PAID')
			""") // Inserts a new payment record with default status PAID
	public Integer insertPayment(
			@Param("bookingId") Integer bookingId, // Related booking ID
			@Param("cardName")String cardName, // Name on card
			@Param("cardNumber")String cardNumber, // Card number
			@Param("paymentType")String paymentType, // Payment type, ex. Credit Card
			@Param("amount")Double amount); // Payment amount
	
	@Select("""
			select payment_id as paymentId,
				booking_id as bookingId,
				card_name as cardName,
				card_number as cardNumber,
				payment_type as paymentType,
				amount,
				payment_date as paymentDate,
				status
			from payments
			where booking_id = #{bookingId}
			""") // Gets payment record by booking ID
	public Payment selectPaymentByBookingId(
			@Param("bookingId")Integer bookingId);
	
	@Select("""
			select payment_id as paymentId,
				booking_id as bookingId,
				card_name as cardName,
				card_number as cardNumber,
				payment_type as paymentType,
				amount,
				payment_date as paymentDate,
				status
			from payments
			order by payment_id desc
			""") // Gets all payments, newest first
	public List<Payment> selectAllPayments();
	
	
	//for pagination
	@Select("""
			select payment_id as paymentId,
				booking_id as bookingId,
				card_name as cardName,
				card_number as cardNumber,
				payment_type as paymentType,
				amount,
				payment_date as paymentDate,
				status
			from payments
			order by payment_id desc
			limit #{limit} offset #{offset}
			""") // Gets payments per page for pagination
	public List<Payment> selectPaymentsPage(
			@Param("limit") Integer limit, // Number of records per page
			@Param("offset") Integer offset); // Starting row for page

	@Select("""
			select count(*)
			from payments
			""") // Counts all payment records
	public Integer countAllPayments();
}