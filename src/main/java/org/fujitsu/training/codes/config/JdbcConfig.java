package org.fujitsu.training.codes.config;

import javax.sql.DataSource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.fujitsu.training.codes.service.BookingService;
import org.fujitsu.training.codes.service.EmailService;
import org.fujitsu.training.codes.service.FeedbackService;
import org.fujitsu.training.codes.service.PackageOptionService;
import org.fujitsu.training.codes.service.PackageService;
import org.fujitsu.training.codes.service.PaymentService;
import org.fujitsu.training.codes.service.UserService;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


@Configuration // Spring -> bean configuration
@MapperScan("org.fujitsu.training.codes.dao") //  MyBatis -> scan for mapper interfaces
public class JdbcConfig {


	@Bean 	// Creates the database connection source
	public DataSource createDataSource() {
		BasicDataSource ds = new BasicDataSource();
		ds.setDriverClassName("org.postgresql.Driver"); 	// PostgreSQL JDBC driver
		ds.setUrl("jdbc:postgresql://localhost:5432/traveldb"); 	// Database URL
		ds.setUsername("postgres");		// Database username
		ds.setPassword("admin2255");	// Database password

		return ds;
	}


	@Bean
	public SqlSessionFactory createSqlSessionFactory(DataSource ds) throws Exception {	// Creates -> MyBatis SqlSessionFactory using the DataSource
		SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
		factoryBean.setDataSource(ds); 	// Connect MyBatis to the database source

		return factoryBean.getObject();
	}

	@Bean
	public UserService createUserService(SqlSessionFactory ssf) {	// Creates -> UserService bean and injects SqlSessionFactory
		return new UserService(ssf);
	}
	
	@Bean
	public EmailService createEmailService() {	// Creates -> EmailService bean
		return new EmailService();
	}
	
	@Bean
	public PackageService createPackageService(SqlSessionFactory ssf) {		// Creates -> PackageService bean and injects SqlSessionFactory
		return new PackageService(ssf);
	}
	
	@Bean
	public BookingService createBookingService(SqlSessionFactory ssf) {		// Creates -> BookingService bean and injects SqlSessionFactory
		return new BookingService(ssf);
	}
	
	@Bean
	public PaymentService createPaymentService(SqlSessionFactory ssf) {		// Creates -> PaymentService bean and injects SqlSessionFactory
		return new PaymentService(ssf);
	}
	
	@Bean
	public FeedbackService createFeedbackService(SqlSessionFactory ssf) {	// Creates -> FeedbackService bean and injects SqlSessionFactory
		return new FeedbackService(ssf);
	}
	
	@Bean
	public PackageOptionService createPackageOptionService(SqlSessionFactory ssf) { 	// // Creates -> PackageOptionService bean and injects SqlSessionFactory
		return new PackageOptionService(ssf);
	}
}