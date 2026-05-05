package org.fujitsu.training.codes.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.fujitsu.training.codes.dao.BookingMapper;
import org.fujitsu.training.codes.model.data.Booking;

public class BookingService {
	
	private static final Logger LOG = LogManager.getLogger(BookingService.class);
	
	private SqlSessionFactory ssf;

	public BookingService(SqlSessionFactory ssf) {
		super();
		this.ssf = ssf;
	}
	
	public boolean createBooking(Integer userId, Integer packageId, Integer optionId, String comments, String travelDate) {
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("Creating booking. userId={}, packageId={}, optionId={}, travelDate={}",
					userId, packageId, optionId, travelDate);
			
			BookingMapper repo = sess.getMapper(BookingMapper.class);
			Integer count = repo.insertBooking(userId, packageId, optionId, comments, travelDate);
			
			LOG.info("Insert booking result count={}", count);
			
			sess.commit();
			sess.close();
			
			if (count > 0) {
				LOG.info("Booking created successfully with PENDING status. userId={}, packageId={}, optionId={}",
						userId, packageId, optionId);
			} else {
				LOG.error("Booking creation failed. userId={}, packageId={}, optionId={}",
						userId, packageId, optionId);
			}
			
			return count > 0;
		} catch (Exception e) {
			LOG.error("Unexpected error while creating booking. userId={}, packageId={}, optionId={}, travelDate={}",
					userId, packageId, optionId, travelDate, e);
			sess.rollback();
			sess.close();
		}
		
		return false;
	}
	
	public List<Booking> selectBookingsByUserId(Integer userId) {
		List<Booking> records = new ArrayList<>();
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("Selecting bookings by userId={}", userId);
			
			BookingMapper repo = sess.getMapper(BookingMapper.class);
			records = repo.selectBookingsByUserId(userId);
			
			LOG.info("Select bookings by userId={} successful. recordCount={}", userId, records.size());
			sess.close();
		} catch (Exception e) {
			LOG.error("Unexpected error while selecting bookings by userId={}", userId, e);
			sess.close();
		}
		
		return records;
	}
	
	public List<Booking> selectAllBookings() {
		List<Booking> records = new ArrayList<>();
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("Selecting all bookings.");
			
			BookingMapper repo = sess.getMapper(BookingMapper.class);
			records = repo.selectAllBookings();
			
			LOG.info("Select all bookings successful. recordCount={}", records.size());
			sess.close();
		} catch (Exception e) {
			LOG.error("Unexpected error while selecting all bookings.", e);
			sess.close();
		}
		
		return records;
	}
	
	public Booking selectBookingById(Integer bookingId) {
		Booking rec = null;
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("Selecting booking by bookingId={}", bookingId);
			
			BookingMapper repo = sess.getMapper(BookingMapper.class);
			rec = repo.selectBookingById(bookingId);
			
			if (rec != null) {
				LOG.info("Select booking by bookingId={} successful.", bookingId);
			} else {
				LOG.error("Booking not found for bookingId={}", bookingId);
			}
			
			sess.close();
		} catch (Exception e) {
			LOG.error("Unexpected error while selecting booking by bookingId={}", bookingId, e);
			sess.close();
		}
		
		return rec;
	}
	
	public boolean cancelBooking(Integer bookingId) {
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("Cancelling booking. bookingId={}", bookingId);
			
			BookingMapper repo = sess.getMapper(BookingMapper.class);
			Integer count = repo.cancelBooking(bookingId);
			
			sess.commit();
			sess.close();
			
			if (count > 0) {
				LOG.info("Booking cancelled successfully. bookingId={}", bookingId);
			} else {
				LOG.error("Booking cancellation failed. bookingId={}", bookingId);
			}
			
			return count > 0;
		} catch (Exception e) {
			LOG.error("Unexpected error while cancelling booking. bookingId={}", bookingId, e);
			sess.rollback();
			sess.close();
		}
		
		return false;
	}

	public boolean updateBookingStatus(Integer bookingId, String status) {
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("Updating booking status. bookingId={}, status={}", bookingId, status);
			
			BookingMapper repo = sess.getMapper(BookingMapper.class);
			Integer count = repo.updateBookingStatus(bookingId, status);
			
			sess.commit();
			sess.close();
			
			if (count > 0) {
				LOG.info("Booking status updated successfully. bookingId={}, status={}", bookingId, status);
			} else {
				LOG.error("Booking status update failed. bookingId={}, status={}", bookingId, status);
			}
			
			return count > 0;
		} catch (Exception e) {
			LOG.error("Unexpected error while updating booking status. bookingId={}, status={}", bookingId, status, e);
			sess.rollback();
			sess.close();
		}
		
		return false;
	}
	
	public int countBookingsByOptionId(Integer optionId) {
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("Counting bookings by optionId={}", optionId);
			
			BookingMapper repo = sess.getMapper(BookingMapper.class);
			Integer count = repo.countBookingsByOptionId(optionId);
			sess.close();
			
			int result = count == null ? 0 : count;
			LOG.info("Count bookings by optionId={} result={}", optionId, result);
			
			return result;
		} catch (Exception e) {
			LOG.error("Unexpected error while counting bookings by optionId={}", optionId, e);
			sess.close();
		}
		
		return 0;
	}
	
	public List<Booking> selectBookingsPage(Integer limit, Integer offset) {
		List<Booking> records = new ArrayList<>();
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("Selecting bookings page. limit={}, offset={}", limit, offset);
			
			BookingMapper repo = sess.getMapper(BookingMapper.class);
			records = repo.selectBookingsPage(limit, offset);
			
			LOG.info("Select bookings page successful. limit={}, offset={}, recordCount={}",
					limit, offset, records.size());
			sess.close();
		} catch (Exception e) {
			LOG.error("Unexpected error while selecting bookings page. limit={}, offset={}", limit, offset, e);
			sess.close();
		}
		
		return records;
	}

	public int countAllBookings() {
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("Counting all bookings.");
			
			BookingMapper repo = sess.getMapper(BookingMapper.class);
			Integer count = repo.countAllBookings();
			sess.close();
			
			int result = count == null ? 0 : count;
			LOG.info("Count all bookings result={}", result);
			
			return result;
		} catch (Exception e) {
			LOG.error("Unexpected error while counting all bookings.", e);
			sess.close();
		}
		
		return 0;
	}
}