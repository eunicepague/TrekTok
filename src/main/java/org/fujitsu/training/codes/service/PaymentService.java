package org.fujitsu.training.codes.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.fujitsu.training.codes.dao.PaymentMapper;
import org.fujitsu.training.codes.model.data.Payment;

public class PaymentService {
	
	private static final Logger LOG = LogManager.getLogger(PaymentService.class); // Logger for payment service actions
	
	private SqlSessionFactory ssf; // MyBatis SqlSessionFactory for database access

	public PaymentService(SqlSessionFactory ssf) {
		super();
		this.ssf = ssf; // Saves injected SqlSessionFactory
	}
	
	public boolean createPayment(
			Integer bookingId,
			String cardName,
			String cardNumber,
			String paymentType,
			Double amount) {
		SqlSession sess = ssf.openSession(); // Opens MyBatis SQL session
		
		try {
			LOG.info("Creating payment. bookingId={}, paymentType={}, amount={}",
					bookingId, paymentType, amount);
			
			PaymentMapper repo = sess.getMapper(PaymentMapper.class); // Gets PaymentMapper
			Integer count = repo.insertPayment(bookingId, cardName, cardNumber, paymentType, amount); // Inserts payment record
			sess.commit(); // Commits transaction
			sess.close(); // Closes session after success
			
			if (count > 0) {
				LOG.info("Payment created successfully. bookingId={}, paymentType={}, amount={}",
						bookingId, paymentType, amount);
			} else {
				LOG.error("Payment creation failed. bookingId={}, paymentType={}, amount={}",
						bookingId, paymentType, amount);
			}
			
			return count > 0; // Returns true if insert worked
		} catch (Exception e) {
			LOG.error("Unexpected error while creating payment. bookingId={}, paymentType={}, amount={}",
					bookingId, paymentType, amount, e);
			sess.rollback(); // Rolls back transaction on error
			sess.close(); // Closes session on error
		}
		return false;
	}
	
	public Payment selectPaymentByBookingId(Integer bookingId)  {
		Payment rec = null; // Default result if nothing found
		SqlSession sess = ssf.openSession(); // Opens MyBatis SQL session
		
		try {
			LOG.info("Selecting payment by bookingId={}", bookingId);
			
			PaymentMapper repo = sess.getMapper(PaymentMapper.class); // Gets PaymentMapper
			rec = repo.selectPaymentByBookingId(bookingId); // Loads payment by booking ID
			sess.close(); // Closes session after success
			
			if (rec != null) {
				LOG.info("Payment found for bookingId={}", bookingId);
			} else {
				LOG.info("No payment found for bookingId={}", bookingId);
			}
		} catch (Exception e) {
			LOG.error("Unexpected error while selecting payment by bookingId={}", bookingId, e);
			sess.close(); // Closes session on error
		}
		return rec;
		
	}
	
	public List<Payment> selectAllPayments() {
		List<Payment> records = new ArrayList<>(); // Default empty list
		SqlSession sess = ssf.openSession(); // Opens MyBatis SQL session
		
		try {
			LOG.info("Selecting all payments.");
			
			PaymentMapper repo = sess.getMapper(PaymentMapper.class); // Gets PaymentMapper
			records = repo.selectAllPayments(); // Loads all payments
			sess.close(); // Closes session after success
			
			LOG.info("Select all payments successful. recordCount={}", records.size());
		} catch (Exception e) {
			LOG.error("Unexpected error while selecting all payments.", e);
			sess.close(); // Closes session on error
		}
		
		return records;
	}
	
	public boolean isBookingPaid(Integer bookingId) {
		LOG.info("Checking if booking is paid. bookingId={}", bookingId);
		Payment rec = selectPaymentByBookingId(bookingId); // Checks if payment record exists for booking
		boolean paid = rec != null; // True if booking already has payment
		LOG.info("Booking payment status checked. bookingId={}, paid={}", bookingId, paid);
		return paid;
	}
	
	
	
	//for pagination
	public List<Payment> selectPaymentsPage(Integer limit, Integer offset) {
		List<Payment> records = new ArrayList<>(); // Default empty list
		SqlSession sess = ssf.openSession(); // Opens MyBatis SQL session
		
		try {
			LOG.info("Selecting payments page. limit={}, offset={}", limit, offset);
			
			PaymentMapper repo = sess.getMapper(PaymentMapper.class); // Gets PaymentMapper
			records = repo.selectPaymentsPage(limit, offset); // Loads paginated payment records
			sess.close(); // Closes session after success
			
			LOG.info("Select payments page successful. limit={}, offset={}, recordCount={}",
					limit, offset, records.size());
		} catch (Exception e) {
			LOG.error("Unexpected error while selecting payments page. limit={}, offset={}", limit, offset, e);
			sess.close(); // Closes session on error
		}
		
		return records;
	}

	public int countAllPayments() {
		SqlSession sess = ssf.openSession(); // Opens MyBatis SQL session
		
		try {
			LOG.info("Counting all payments.");
			
			PaymentMapper repo = sess.getMapper(PaymentMapper.class); // Gets PaymentMapper
			Integer count = repo.countAllPayments(); // Counts all payment records
			sess.close(); // Closes session after success
			
			int result = count == null ? 0 : count; // Prevents null count
			LOG.info("Count all payments result={}", result);
			
			return result;
		} catch (Exception e) {
			LOG.error("Unexpected error while counting all payments.", e);
			sess.close(); // Closes session on error
		}
		
		return 0;
	}
}