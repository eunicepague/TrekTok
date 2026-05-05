package org.fujitsu.training.codes.dao;

import java.time.LocalDateTime;
import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.fujitsu.training.codes.model.data.User;

public interface UserMapper {

	@Select("""
			select user_id as userId,
				first_name as firstName,
				last_name as lastName,
				email,
				password,
				contact_no as contactNo,
				is_verified as isVerified,
				verification_code as verificationCode,
				role,
				account_status as accountStatus,
				reset_code as resetCode,
				reset_code_expiry as resetCodeExpiry
			from users
			where email = #{email}
			""") // Gets one user by email
	public User selectByEmail(@Param("email") String email);
	
	@Insert("""
			insert into users(first_name, last_name, email, password, contact_no, is_verified, verification_code)
			values(#{firstName}, #{lastName}, #{email}, #{password}, #{contactNo}, false, #{verificationCode})
			""") // Inserts a new user with default is_verified = false
	public Integer insertUser(
			@Param("firstName")String firstName, // User first name
			@Param("lastName")String lastName, // User last name
			@Param("email")String email, // User email
			@Param("password")String password, // User password
			@Param("contactNo")String contactNo, // User contact number
			@Param("verificationCode")String verificationCode); // Email verification code
	
	@Update("""
			update users
			set is_verified = true
			where email = #{email} and verification_code = #{verificationCode}
			""") // Verifies user account if email and code match
	public Integer verifyUser(
			@Param("email")String email,
			@Param("verificationCode")String verificationCode);

	@Select("""
			select user_id as userId,
				first_name as firstName,
				last_name as lastName,
				email,
				password,
				contact_no as contactNo,
				is_verified as isVerified,
				verification_code as verificationCode,
				role,
				account_status as accountStatus,
				reset_code as resetCode,
				reset_code_expiry as resetCodeExpiry
			from users
			order by user_id
			""") // Gets all users for admin view
	public List<User> selectAllUsers();
	
	@Update("""
			update users
			set role = #{role}
			where user_id = #{userId}
			""") // Updates user role by user ID
	public Integer updateUserRole(@Param("userId") Integer userId,
			@Param("role") String role);

	@Update("""
			update users
			set account_status = #{accountStatus}
			where user_id = #{userId}
			""") // Updates account status by user ID
	public Integer updateAccountStatus(@Param("userId") Integer userId,
			@Param("accountStatus") String accountStatus);

	@Update("""
			update users
			set reset_code = #{resetCode},
			    reset_code_expiry = #{resetCodeExpiry}
			where email = #{email}
			""") // Saves reset code and expiry time for forgot password
	public Integer updateResetCode(@Param("email") String email,
			@Param("resetCode") String resetCode,
			@Param("resetCodeExpiry") LocalDateTime resetCodeExpiry);

	@Update("""
			update users
			set password = #{password}
			where email = #{email}
			""") // Updates password using email
	public Integer updatePasswordByEmail(@Param("email") String email,
			@Param("password") String password);

	@Update("""
			update users
			set reset_code = null,
			    reset_code_expiry = null
			where email = #{email}
			""") // Clears reset code and expiry after successful password reset
	public Integer clearResetCode(@Param("email") String email);
}