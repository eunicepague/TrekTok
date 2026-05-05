package org.fujitsu.training.codes.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.fujitsu.training.codes.dao.UserMapper;
import org.fujitsu.training.codes.model.data.User;

public class UserService {
	
	private static final Logger LOG = LogManager.getLogger(UserService.class);
	
	private SqlSessionFactory ssf;

	public UserService(SqlSessionFactory ssf) {
		super();
		this.ssf = ssf;
	}
	
	public User login(String email, String password) {
		User rec = null;
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("User login lookup started for email={}", email);
			
			UserMapper repo = sess.getMapper(UserMapper.class);
			rec = repo.selectByEmail(email);
			
			if (rec != null) {
				LOG.info("User found for login. email={}, verified={}, role={}, accountStatus={}",
						rec.getEmail(), rec.getIsVerified(), rec.getRole(), rec.getAccountStatus());
				
				if (rec.getPassword().equals(password)
						&& Boolean.TRUE.equals(rec.getIsVerified())
						&& "ACTIVE".equalsIgnoreCase(rec.getAccountStatus())) {
					LOG.info("User login passed in service for userId={}, email={}", rec.getUserId(), rec.getEmail());
					sess.close();
					return rec;
				}
				
				LOG.error("User login failed in service for email={}: password mismatch, not verified, or inactive.", email);
			} else {
				LOG.error("User login failed in service: email not found. email={}", email);
			}
			
			sess.close();
		} catch (Exception e) {
			LOG.error("Unexpected error during login for email={}", email, e);
			sess.close();
		}
		
		return null;
	}
	
	public String generateVerificationCode() {
		Random rand = new Random();
		int code = 100000 + rand.nextInt(900000);
		return String.valueOf(code);
	}
	
	public String register(String firstName, String lastName, String email,
			String password, String contactNo) {
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("User registration started for email={}", email);
			
			UserMapper repo = sess.getMapper(UserMapper.class);
			User rec = repo.selectByEmail(email);
			
			if (rec != null) {
				LOG.error("User registration failed: email already exists. email={}", email);
				sess.close();
				return null;
			}
			
			String verificationCode = generateVerificationCode();
			
			Integer count = repo.insertUser(firstName, lastName, email, password, contactNo, verificationCode);
			sess.commit();
			sess.close();
			
			if (count > 0) {
				LOG.info("User registration successful for email={}", email);
				return verificationCode;
			}
			
			LOG.error("User registration failed: insert returned no rows. email={}", email);
		} catch (Exception e) {
			LOG.error("Unexpected error during registration for email={}", email, e);
			sess.rollback();
			sess.close();
		}
		
		return null;
	}
	
	public boolean verifyUser(String email, String verificationCode) {
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("User verification started for email={}", email);
			
			UserMapper repo = sess.getMapper(UserMapper.class);
			Integer count = repo.verifyUser(email, verificationCode);
			LOG.info("User verification update count for email={} is {}", email, count);
			sess.commit();
			sess.close();
			
			if (count > 0) {
				LOG.info("User verification successful for email={}", email);
			} else {
				LOG.error("User verification failed for email={}: invalid code or no rows updated.", email);
			}
			
			return count > 0;
		} catch (Exception e) {
			LOG.error("Unexpected error during verification for email={}", email, e);
			sess.rollback();
			sess.close();
		}
		
		return false;
	}
	
	public List<User> selectAllUsers() {
		List<User> records = new ArrayList<>();
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("Selecting all users.");
			
			UserMapper repo = sess.getMapper(UserMapper.class);
			records = repo.selectAllUsers();
			LOG.info("Select all users successful. recordCount={}", records.size());
			sess.close();
		} catch (Exception e) {
			LOG.error("Unexpected error while selecting all users.", e);
			sess.close();
		}
		
		return records;
	}

	public User selectUserById(Integer userId) {
		List<User> records = selectAllUsers();
		
		for (User rec : records) {
			if (rec.getUserId() != null && rec.getUserId().equals(userId)) {
				return rec;
			}
		}
		
		return null;
	}
	
	public boolean updateUserRole(Integer userId, String role) {
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("Updating user role. userId={}, role={}", userId, role);
			
			UserMapper repo = sess.getMapper(UserMapper.class);
			Integer count = repo.updateUserRole(userId, role);
			sess.commit();
			sess.close();
			
			if (count > 0) {
				LOG.info("User role updated successfully. userId={}, role={}", userId, role);
			} else {
				LOG.error("User role update failed. userId={}, role={}", userId, role);
			}
			
			return count > 0;
		} catch (Exception e) {
			LOG.error("Unexpected error while updating user role. userId={}, role={}", userId, role, e);
			sess.rollback();
			sess.close();
		}
		
		return false;
	}

	public boolean updateAccountStatus(Integer userId, String accountStatus) {
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("Updating account status. userId={}, accountStatus={}", userId, accountStatus);
			
			UserMapper repo = sess.getMapper(UserMapper.class);
			Integer count = repo.updateAccountStatus(userId, accountStatus);
			sess.commit();
			sess.close();
			
			if (count > 0) {
				LOG.info("Account status updated successfully. userId={}, accountStatus={}", userId, accountStatus);
			} else {
				LOG.error("Account status update failed. userId={}, accountStatus={}", userId, accountStatus);
			}
			
			return count > 0;
		} catch (Exception e) {
			LOG.error("Unexpected error while updating account status. userId={}, accountStatus={}", userId, accountStatus, e);
			sess.rollback();
			sess.close();
		}
		
		return false;
	}

	public String createResetCode(String email) {
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("Creating reset code for email={}", email);
			
			UserMapper repo = sess.getMapper(UserMapper.class);
			User rec = repo.selectByEmail(email);
			
			if (rec == null) {
				LOG.error("Create reset code failed: email not found. email={}", email);
				sess.close();
				return null;
			}
			
			String resetCode = generateVerificationCode();
			LocalDateTime expiry = LocalDateTime.now().plusMinutes(10);
			
			Integer count = repo.updateResetCode(email, resetCode, expiry);
			sess.commit();
			sess.close();
			
			if (count > 0) {
				LOG.info("Reset code created successfully for email={}", email);
				return resetCode;
			}
			
			LOG.error("Create reset code failed: no rows updated. email={}", email);
		} catch (Exception e) {
			LOG.error("Unexpected error while creating reset code for email={}", email, e);
			sess.rollback();
			sess.close();
		}
		
		return null;
	}

	public boolean resetPassword(String email, String resetCode, String newPassword) {
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("Reset password started for email={}", email);
			
			UserMapper repo = sess.getMapper(UserMapper.class);
			User rec = repo.selectByEmail(email);
			
			if (rec == null) {
				LOG.error("Reset password failed: email not found. email={}", email);
				sess.close();
				return false;
			}
			
			if (rec.getResetCode() == null || rec.getResetCodeExpiry() == null) {
				LOG.error("Reset password failed: reset code data missing. email={}", email);
				sess.close();
				return false;
			}
			
			if (!resetCode.equals(rec.getResetCode())) {
				LOG.error("Reset password failed: reset code mismatch. email={}", email);
				sess.close();
				return false;
			}
			
			if (LocalDateTime.now().isAfter(rec.getResetCodeExpiry())) {
				LOG.error("Reset password failed: reset code expired. email={}", email);
				sess.close();
				return false;
			}
			
			Integer count1 = repo.updatePasswordByEmail(email, newPassword);
			Integer count2 = repo.clearResetCode(email);
			sess.commit();
			sess.close();
			
			if (count1 > 0 && count2 > 0) {
				LOG.info("Reset password successful for email={}", email);
			} else {
				LOG.error("Reset password failed after update. email={}, passwordUpdateCount={}, clearCodeCount={}",
						email, count1, count2);
			}
			
			return count1 > 0 && count2 > 0;
		} catch (Exception e) {
			LOG.error("Unexpected error during reset password for email={}", email, e);
			sess.rollback();
			sess.close();
		}
		
		return false;
	}
}