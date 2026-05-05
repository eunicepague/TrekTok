package org.fujitsu.training.codes.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.fujitsu.training.codes.dao.FeedbackMapper;
import org.fujitsu.training.codes.model.data.Feedback;

public class FeedbackService {
	private SqlSessionFactory ssf; // MyBatis SqlSessionFactory for database access

	public FeedbackService(SqlSessionFactory ssf) {
		super();
		this.ssf = ssf; // Saves injected SqlSessionFactory
	}
	
	public boolean createFeedback(
			Integer userId,
			Integer bookingId,
			String packageName,
			String email,
			String contactNo,
			String message,
			Integer rating) {
		
		SqlSession sess = ssf.openSession(); // Opens MyBatis SQL session
		
		try {
			FeedbackMapper repo = sess.getMapper(FeedbackMapper.class); // Gets FeedbackMapper
			Integer count = repo.insertFeedback(userId, bookingId, packageName, email, contactNo, message, rating); // Inserts feedback record
			sess.commit(); // Commits transaction
			sess.close(); // Closes session after success
			
			return count > 0; // Returns true if insert worked
		} catch (Exception e) {
			sess.rollback(); // Rolls back transaction on error
			sess.close(); // Closes session on error
			e.printStackTrace();
		}
		return false;
	}
	
	public List<Feedback> selectAllFeedback() {
		List<Feedback> records = new ArrayList<>(); // Default empty list
		SqlSession sess = ssf.openSession(); // Opens MyBatis SQL session
		
		try {
			FeedbackMapper repo = sess.getMapper(FeedbackMapper.class); // Gets FeedbackMapper
			records = repo.selectAllFeedback(); // Loads all feedback records
			sess.close(); // Closes session after success
		} catch (Exception e) {
			sess.close(); // Closes session on error
			e.printStackTrace();
		}
		
		return records;
	}
	
	public Feedback selectFeedbackById(Integer feedbackId) {
		Feedback rec = null; // Default result if nothing found
		SqlSession sess = ssf.openSession(); // Opens MyBatis SQL session
		
		try {
			FeedbackMapper repo = sess.getMapper(FeedbackMapper.class); // Gets FeedbackMapper
			rec = repo.selectFeedbackById(feedbackId); // Loads one feedback by ID
			sess.close(); // Closes session after success
		} catch (Exception e) {
			sess.close(); // Closes session on error
			e.printStackTrace();
		}
		
		return rec;
	}
	
	public boolean updateFeedback(Integer feedbackId, String adminRemarks, String status) {
		SqlSession sess = ssf.openSession(); // Opens MyBatis SQL session
		
		try {
			FeedbackMapper repo = sess.getMapper(FeedbackMapper.class); // Gets FeedbackMapper
			Integer count = repo.updateFeedback(feedbackId, adminRemarks, status); // Updates feedback admin remarks and status
			sess.commit(); // Commits transaction
			sess.close(); // Closes session after success
			
			return count > 0; // Returns true if update worked
		} catch (Exception e) {
			sess.rollback(); // Rolls back transaction on error
			sess.close(); // Closes session on error
			e.printStackTrace();
		}
		return false;
	}
	
	public List<Feedback> selectFeedbackByUserId(Integer userId) {
		List<Feedback> records = new ArrayList<>(); // Default empty list
		SqlSession sess = ssf.openSession(); // Opens MyBatis SQL session
		
		try {
			FeedbackMapper repo = sess.getMapper(FeedbackMapper.class); // Gets FeedbackMapper
			records = repo.selectFeedbackByUserId(userId); // Loads feedback of one user
			sess.close(); // Closes session after success
		} catch (Exception e) {
			sess.close(); // Closes session on error
			e.printStackTrace();
		}
		
		return records;
	}
	
	
	//for pagination
	public List<Feedback> selectFeedbackPage(Integer limit, Integer offset) {
		List<Feedback> records = new ArrayList<>(); // Default empty list
		SqlSession sess = ssf.openSession(); // Opens MyBatis SQL session
		
		try {
			FeedbackMapper repo = sess.getMapper(FeedbackMapper.class); // Gets FeedbackMapper
			records = repo.selectFeedbackPage(limit, offset); // Loads paginated feedback records
			sess.close(); // Closes session after success
		} catch (Exception e) {
			sess.close(); // Closes session on error
			e.printStackTrace();
		}
		
		return records;
	}

	public int countAllFeedback() {
		SqlSession sess = ssf.openSession(); // Opens MyBatis SQL session
		
		try {
			FeedbackMapper repo = sess.getMapper(FeedbackMapper.class); // Gets FeedbackMapper
			Integer count = repo.countAllFeedback(); // Counts all feedback records
			sess.close(); // Closes session after success
			
			return count == null ? 0 : count; // Returns 0 if count is null
		} catch (Exception e) {
			sess.close(); // Closes session on error
			e.printStackTrace();
		}
		
		return 0;
	}
}